# Copyright 2017 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""The piptool module imports pip requirements into Bazel rules."""

import argparse
import atexit
import itertools
import json
import os
import pkgutil
import pkg_resources
import re
import requests
import shutil
import sys
import tempfile
import zipfile

# Note: We carefully import the following modules in a particular
# order, since these modules modify the import path and machinery.
import pkg_resources


def extract_packages(package_names):
    """Extract zipfile contents to disk and add to import path"""

    # Set a safe extraction dir
    extraction_tmpdir = tempfile.mkdtemp()
    atexit.register(lambda: shutil.rmtree(
        extraction_tmpdir, ignore_errors=True))
    pkg_resources.set_extraction_path(extraction_tmpdir)

    # Extract each package to disk
    dirs_to_add = []
    for package_name in package_names:
        req = pkg_resources.Requirement.parse(package_name)
        extraction_dir = pkg_resources.resource_filename(req, '')
        dirs_to_add.append(extraction_dir)

    # Add extracted directories to import path ahead of their zip file
    # counterparts.
    sys.path[0:0] = dirs_to_add
    existing_pythonpath = os.environ.get('PYTHONPATH')
    if existing_pythonpath:
        dirs_to_add.extend(existing_pythonpath.split(':'))
    os.environ['PYTHONPATH'] = ':'.join(dirs_to_add)


# Wheel, pip, and setuptools are much happier running from actual
# files on disk, rather than entries in a zipfile.  Extract zipfile
# contents, add those contents to the path, then import them.
extract_packages(['pip', 'setuptools', 'wheel'])

# Defeat pip's attempt to mangle sys.path
saved_sys_path = sys.path
sys.path = sys.path[:]
import pip
sys.path = saved_sys_path

import setuptools
import wheel


def pip_main(argv):
    # Extract the certificates from the PAR following the example of get-pip.py
    # https://github.com/pypa/get-pip/blob/430ba37776ae2ad89/template.py#L164-L168
    cert_path = os.path.join(tempfile.mkdtemp(), "cacert.pem")
    with open(cert_path, "wb") as cert:
      cert.write(pkgutil.get_data("pip._vendor.requests", "cacert.pem"))
    argv = ["--disable-pip-version-check", "--cert", cert_path] + argv
    return pip.main(argv)

from rules_python.whl import Wheel


global_parser = argparse.ArgumentParser(
    description='Import Python dependencies into Bazel.')
subparsers = global_parser.add_subparsers()


# piptool build
# -------------

def build_wheel(args):
  pip_args = ["wheel"]
  if args.directory:
    pip_args += ["-w", args.directory]
  if len(args.args) > 0 and args.args[0] == '--':
    pip_args += args.args[1:]
  else:
    pip_args += args.args
  # https://github.com/pypa/pip/blob/9.0.1/pip/__init__.py#L209
  if pip_main(pip_args):
    sys.exit(1)

def build(args):
  build_wheel(args)

parser = subparsers.add_parser('build', help='Download or build a single wheel')
parser.set_defaults(func=build)

parser.add_argument('--directory', action='store', default='.',
                    help=('The directory into which to put .whl files.'))

parser.add_argument('args', nargs=argparse.REMAINDER,
                    help=('Extra arguments to send to pip.'))


# piptool extract
# ---------------

def extract(args):
  whls = [Wheel(w) for w in args.whl]
  whl = whls[0]

  extra_deps = args.add_dependency
  if not extra_deps:
      extra_deps = []

  # Extract the files into the current directory
  # TODO(conrado): do one expansion for each extra? It might be easier to create completely new
  # wheel repos
  for w in whls:
    w.expand(args.directory)

  imports = ['.']
  purelib_path = os.path.join('%s-%s.data' % (whl.distribution(), whl.version()), 'purelib')
  if os.path.isdir(os.path.join(args.directory, purelib_path)):
      imports.append(purelib_path)

  wheel_map = {w.name(): w for w in whls}
  external_deps = [d for d in itertools.chain(whl.dependencies(), extra_deps) if d not in wheel_map]

  with open(os.path.join(args.directory, 'BUILD'), 'w') as f:
    f.write("""
package(default_visibility = ["//visibility:public"])

load("@{repository}//:requirements.bzl", "requirement")

filegroup(
  name = "wheel",
  data = ["{wheel}"],
)
py_library(
    name = "pkg",
    srcs = glob(["**/*.py"]),
    data = glob(["**/*"], exclude=["**/*.py", "**/* *", "*.whl", "BUILD", "WORKSPACE"]),
    # This makes this directory a top-level in the python import
    # search path for anything that depends on this.
    imports = [{imports}],
    deps = [
        {dependencies}
    ],
)
{extras}""".format(
  wheel = whl.basename(),
  repository=args.repository,
  dependencies=''.join([
    ('\n        "%s",' % d) if d[0] == "@" else ('\n        requirement("%s"),' % d)
    for d in external_deps
  ]),
  imports=','.join(map(lambda i: '"%s"' % i, imports)),
  extras='\n\n'.join([
    """py_library(
    name = "{extra}",
    deps = [
        ":pkg",{deps}
    ],
)""".format(extra=extra,
            deps=','.join([
                'requirement("%s")' % dep
                for dep in whl.dependencies(extra)
            ]))
    for extra in args.extras or []
  ])))

parser = subparsers.add_parser('extract', help='Extract one or more wheels as a py_library')
parser.set_defaults(func=extract)

parser.add_argument('--whl', action='append', required=True,
                    help=('The .whl file we are expanding.'))

parser.add_argument('--repository', action='store',  required=True,
                    help='The pip_import from which to draw dependencies.')

parser.add_argument('--add-dependency', action='append',
                    help='Specify additional dependencies beyond the ones specified in the wheel.')

parser.add_argument('--directory', action='store', default='.',
                    help='The directory into which to expand things.')

parser.add_argument('--extras', action='append',
                    help='The set of extras for which to generate library targets.')


# piptool resolve
# ---------------

def determine_possible_extras(whls):
  """Determines the list of possible "extras" for each .whl

  The possibility of an extra is determined by looking at its
  additional requirements, and determinine whether they are
  satisfied by the complete list of available wheels.

  Args:
    whls: a list of Wheel objects

  Returns:
    a dict that is keyed by the Wheel objects in whls, and whose
    values are lists of possible extras.
  """
  whl_map = {
    whl.name(): whl
    for whl in whls
  }

  # TODO(mattmoor): Consider memoizing if this recursion ever becomes
  # expensive enough to warrant it.
  def is_possible(name, extra):
    # If we don't have the .whl at all, then this isn't possible.
    if name not in whl_map:
      return False
    whl = whl_map[name]
    # If we have the .whl, and we don't need anything extra then
    # we can satisfy this dependency.
    if not extra:
      return True
    # If we do need something extra, then check the extra's
    # dependencies to make sure they are fully satisfied.
    for extra_dep in whl.dependencies(extra=extra):
      req = pkg_resources.Requirement.parse(extra_dep)
      # Check that the dep and any extras are all possible.
      if not is_possible(req.project_name, None):
        return False
      for e in req.extras:
        if not is_possible(req.project_name, e):
          return False
    # If all of the dependencies of the extra are satisfiable then
    # it is possible to construct this dependency.
    return True

  return {
    whl: [
      extra
      for extra in whl.extras()
      if is_possible(whl.name(), extra)
    ]
    for whl in whls
  }

def resolve(args):
  pip_args = ["wheel"]
  #pip_args += ["--cache-dir", cache_dir]
  if args.directory:
    pip_args += ["-w", args.directory]
  if args.input:
    pip_args += ["-r", args.input]
  if len(args.args) > 0 and args.args[0] == '--':
    pip_args += args.args[1:]
  else:
    pip_args += args.args
  # https://github.com/pypa/pip/blob/9.0.1/pip/__init__.py#L209
  if pip_main(pip_args):
    sys.exit(1)

  # Enumerate the .whl files we downloaded.
  def wheels_from_dir(dir):
    def list_whls(dir):
      for root, _, filenames in os.walk(dir + "/"):
        for fname in filenames:
          if fname.endswith('.whl'):
            yield Wheel(os.path.join(root, fname))
    whls = list(list_whls(dir))
    whls.sort(key=lambda x: x.name())
    return whls

  whls = wheels_from_dir(args.directory)
  possible_extras = determine_possible_extras(whls)

  def quote(string):
    return '"{}"'.format(string)

  if args.output_format == 'download':
    # We are generating a checked-in version of requirements.bzl.
    # For determinism, avoid clashes with other pip_import repositories,
    # and prefix the current pip_import domain to the lib repo name.
    lib_repo = lambda w: w.repository_name(prefix=args.name)
    # Each wheel has its own repository that, refer to that.
    wheel_repo = lambda w: lib_repo(w) + '_wheel'
  else:
    # We are generating requirements.bzl to the bazel output area (legacy mode).
    # Use the good old 'pypi__' refix.
    lib_repo = lambda w: w.repository_name(prefix='pypi')
    # Wheels are downloaded to the pip_import repository, refer to that.
    wheel_repo = lambda w: args.name

  def whl_library(wheel):
    attrs = {"name": quote(lib_repo(wheel))}
    attrs["requirement"] = '"{}=={}"'.format(wheel.name(), wheel.version())
    if args.output_format != 'download':
      attrs["whl"] = '"@{}//:{}"'.format(args.name, wheel.basename())
    extras = ', '.join([quote(extra) for extra in possible_extras.get(wheel, [])])
    if extras != '':
      attrs["extras"] = '[{}]'.format(extras)
    runtime_deps = ', '.join([quote(dep) for dep in wheel.dependencies()])
    if runtime_deps != '':
      attrs["runtime_deps"] = '[{}]'.format(runtime_deps)

    # Indentation here matters.  whl_library must be within the scope
    # of the function below.  We also avoid reimporting an existing WHL.
    return """
  whl_library(
    {},
  )""".format(",\n    ".join(["{} = {}".format(k, v) for k, v in attrs.items()]))

  requirements_map = ',\n  '.join([
    ',\n  '.join([
      '"{name}": "@{repo}//:pkg",\n  "{name}:dirty": "@{repo}_dirty//:pkg"'.format(
          name=whl.name(), repo=lib_repo(whl))
    ] + [
      # For every extra that is possible from this requirements.txt
      '"{name}[{extra_lower}]": "@{repo}//:{extra}",\n  "{name}:dirty[{extra_lower}]": "@{repo}_dirty//:{extra}"'.format(
        name=whl.name(), repo=lib_repo(whl), extra=extra, extra_lower=extra.lower())
      for extra in possible_extras.get(whl, [])
    ])
    for whl in whls
  ])
  wheels_map = ',\n  '.join([
    ',\n  '.join([
      '"{name}": "@{repo}//:{whl}"'.format(
          name=whl.name(), repo=wheel_repo(whl), whl=whl.basename())
    ])
    for whl in whls
  ])

  with open(args.output, 'w') as f:
    f.write("""\
# Install pip requirements.
#
# Generated from {input}

load("@{name}//python:whl.bzl", _whl_library = "whl_library")

_requirements = {{
  {requirements_map}
}}

_wheels = {{
  {wheels_map}
}}

all_requirements = _requirements.values()

def requirement(name):
  if name not in _requirements:
    fail("Could not find pip-provided dependency: '%s'" % name)
  return _requirements[name]

def whl_library(**kwargs):
  _whl_library(wheels_map=_wheels, **kwargs)

def pip_install():
{whl_libraries}

""".format(input=args.input, name=args.name,
           whl_libraries='\n'.join(map(whl_library, whls)) if whls else "pass",
           requirements_map=requirements_map, wheels_map=wheels_map))

parser = subparsers.add_parser('resolve', help='Resolve requirements.bzl from requirements.txt')
parser.set_defaults(func=resolve)

parser.add_argument('--name', action='store', required=True,
                    help=('The namespace of the import.'))

parser.add_argument('--input', action='store', required=True,
                    help=('The requirements.txt file to import.'))

parser.add_argument('--output', action='store', required=True,
                    help=('The requirements.bzl file to export.'))

parser.add_argument('--output-format', choices=['refer', 'download'], default='refer',
                    help=('How whl_library rules should obtain the wheel.'))

parser.add_argument('--directory', action='store', default='.',
                    help=('The directory into which to put .whl files.'))

parser.add_argument('args', nargs=argparse.REMAINDER,
                    help=('Extra arguments to send to pip.'))


def main():
  args = global_parser.parse_args()
  args.func(args)

if __name__ == '__main__':
  main()
