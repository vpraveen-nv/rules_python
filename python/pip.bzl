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
"""Import pip requirements into Bazel."""

def _pip_import_impl(ctx):
  """Core implementation of pip_import."""

  ctx.file("BUILD", """
package(default_visibility = ["//visibility:public"])
sh_binary(
    name = "update",
    srcs = ["update.sh"],
)
""")

  ctx.template(
    "requirements.bzl",
    Label("//rules_python:requirements.bzl.tpl"),
    substitutions = {
      "%{repo}": ctx.name,
      "%{python}": str(ctx.attr.python) if ctx.attr.python else "",
      "%{pip_args}": ", ".join(["\"%s\"" % arg for arg in ctx.attr.pip_args]),
      "%{additional_attributes}": ctx.attr.requirements_overrides or "{}",
    })


  cmd = [
    ctx.path(ctx.attr.python) if ctx.attr.python else "python",
    ctx.path(ctx.attr._script),
    "resolve",
    "--name=%s" % ctx.attr.name,
    "--build-info='%s'" % ctx.attr.requirements_overrides,
    "--pip-arg=--cache-dir=%s" % str(ctx.path("pip-cache")),
  ] + [
    "--input=%s" % str(ctx.path(f)) for f in ctx.attr.requirements
  ] + [
    "--pip-arg=%s" % x for x in ctx.attr.pip_args
  ]


  if ctx.attr.requirements_bzl:
    cmd += [
        "--output=%s" % str(ctx.path(ctx.attr.requirements_bzl)),
        "--output-format=download",
        "--directory=%s" % str(ctx.path("build-directory")),
    ]
    if ctx.attr.digests:
        cmd += ["--digests"]
    cmd += ['"$@"']  # Allow users to augment/override flags from command line

    ctx.file(
        "update.sh",
        "#!/bin/bash\n%s\n" % " ".join(cmd),
        executable = True,
    )

    ctx.symlink(ctx.path(ctx.attr.requirements_bzl), "requirements.gen.bzl")
  else:
    cmd += [
        "--output", ctx.path("requirements.gen.bzl"),
        "--directory", ctx.path(""),
    ]
    result = ctx.execute(cmd, quiet=False)

    if result.return_code:
        fail("pip_import failed: %s (%s)" % (result.stdout, result.stderr))

_pip_import = repository_rule(
    attrs = {
        "requirements": attr.label_list(
            allow_files = True,
            mandatory = True,
        ),
        "requirements_bzl": attr.label(
            allow_files = True,
            single_file = True,
        ),
        "requirements_overrides": attr.string(),
        "pip_args": attr.string_list(),
        "digests": attr.bool(default = False),
        "python": attr.label(
            executable = True,
            cfg = "host",
        ),
        "_script": attr.label(
            executable = True,
            default = Label("//tools:piptool.par"),
            cfg = "host",
        ),
    },
    implementation = _pip_import_impl,
)

def pip_import(**kwargs):
    if "requirements_overrides" in kwargs:
        # Overrides are serialized to string and passed to the rule, since
        # rules cannot have deep dicts.
        kwargs["requirements_overrides"] = str(kwargs["requirements_overrides"])
    _pip_import(**kwargs)


"""A rule for importing <code>requirements.txt</code> dependencies into Bazel.

This rule imports a <code>requirements.txt</code> file and generates a new
<code>requirements.bzl</code> file.  This is used via the <code>WORKSPACE</code>
pattern:
<pre><code>pip_import(
    name = "foo",
    requirements = ":requirements.txt",
)
load("@foo//:requirements.bzl", "pip_install")
pip_install()
</code></pre>

You can then reference imported dependencies from your <code>BUILD</code>
file with:
<pre><code>load("@foo//:requirements.bzl", "requirement")
py_library(
    name = "bar",
    ...
    deps = [
       "//my/other:dep",
       requirement("futures"),
       requirement("mock"),
    ],
)
</code></pre>

Or alternatively:
<pre><code>load("@foo//:requirements.bzl", "all_requirements")
py_binary(
    name = "baz",
    ...
    deps = [
       ":foo",
    ] + all_requirements,
)
</code></pre>

Args:
  requirements: The label of a requirements.txt file.
"""

def _pip_version_proxy_impl(ctx):
    loads = "".join(["""\
load("{repo}//:requirements.bzl", wheels_{key} = "wheels")
""".format(repo=v, key=k) for k, v in ctx.attr.values.items()])

    gathers = "".join(["""\
    for k, v in wheels_{key}.items():
        if k not in all_reqs:
            all_reqs[k] = {{}}
        all_reqs[k]["{key}"] = "@%s//:pkg" % v["name"]
        for e in v.get("extras", []) + v.get("additional_targets", []):
            ek = "%s[%s]" % (k, e)
            if ek not in all_reqs:
                all_reqs[ek] = {{}}
            all_reqs[ek]["{key}"] = "@%s//:%s" % (v["name"], e)
""".format(key=k) for k in ctx.attr.values.keys()])

    config_settings = "".join(["""\
config_setting(
    name = "{key}",
    define_values = {{
        "{define}": "{key}",
    }},
)
""".format(define=ctx.attr.define, key=k) for k in ctx.attr.values.keys()])

    specific_macros = "".join(["""\
def requirement_{key}(r):
    return "@{name}//:{key}__%s" % _sanitize(r)
""".format(name=ctx.attr.name, key=k) for k in ctx.attr.values.keys()])

    update_deps = "".join(["""\
        "{repo}//:update",
""".format(repo=v, key=k) for k, v in ctx.attr.values.items()])

    update_locations = "".join(["""\
        "$(location {repo}//:update)",
""".format(repo=v, key=k) for k, v in ctx.attr.values.items()])

    ctx.file("BUILD.bazel", content="""\
load("@{name}//:requirements.bzl", "proxy_install")
package(default_visibility = ["//visibility:public"])

py_library(name = "empty")

proxy_install()

sh_binary(
    name = "update",
    srcs = ["update.sh"],
    data = [
        {update_deps}
    ],
    args = [
        {update_locations}
    ],
)

{config_settings}
""".format(name=ctx.attr.name, config_settings=config_settings, update_deps=update_deps,
           update_locations=update_locations))

    ctx.file("update.sh", content="""\
#!/bin/bash
set -eo pipefail

for cmd in "$@"; do
    "$cmd" &
done

for job in `jobs -p`; do
    wait $job || true
done
""", executable=True)

    ctx.file("requirements.bzl", content="""\
{loads}

def _sanitize(s):
    return s.replace('[', '_').replace(']', '_').replace(':', '_').replace('-', '_')

# Called from autogenerated BUILD file.
# Generate proxy py_library targets that use select() to pick the real wheel.
def proxy_install():
    all_reqs = {{}}
{gathers}
    for req, gathers in all_reqs.items():
        conditions = {{k: v for k, v in gathers.items()}}
        name = _sanitize(req)
        native.alias(
            name = name,
            actual = select(conditions),
        )
        for py_version, label in gathers.items():
            native.alias(
                name = py_version + "__" + name,
                actual = select({{
                    py_version: label,
                    "//conditions:default": "@{name}//:empty",
                }}),
            )


def requirement(name, target = "pkg", binary = None):
    if target != "pkg":
        name = "%s[%s]" % (name, target)
    return "@{name}//:%s" % _sanitize(name).lower()
{specific_macros}
""".format(loads=loads, gathers=gathers, specific_macros=specific_macros, name=ctx.attr.name))

pip_version_proxy = repository_rule(
    attrs = {
        "define": attr.string(),
        "values": attr.string_dict(),
        "_script": attr.label(
            executable = True,
            default = Label("//tools:piptool.par"),
            cfg = "host",
        ),
        "python": attr.label(
            executable = True,
            cfg = "host",
        ),
    },
    implementation = _pip_version_proxy_impl,
)

"""A rule for proxying requirements between different python runtimes.

This rule generates a <code>requirements.bzl</code> file that provides
a <code>requirements()</code> function that resolves to the correct version
of python dependencies depending on the current python runtime.
This is used via the <code>WORKSPACE</code> pattern:

<pre><code>pip_import(
    name = "pip_deps2",
    requirements = ["//:requirements-pip.txt"],
    python = "@python2//:bin/python",
)
pip_import(
    name = "pip_deps3",
    requirements = ["//:requirements-pip.txt"],
    python = "@python3//:bin/python",
)
load("@pip_deps2//:requirements.bzl", pip_install2 = "pip_install")
pip_install2()
load("@pip_deps3//:requirements.bzl", pip_install3 = "pip_install")
pip_install3()

pip_version_proxy(
    name = "pip_deps",
    define = "python",
    values = {
        "py2": "@pip_deps2",
        "py3": "@pip_deps3",
    },
)
</code></pre>

When importing dependencies from a <code>BUILD</code> file with

<pre><code>load("@pip_deps//:requirements.bzl", "requirement")
py_library(
    name = "bar",
    ...
    deps = [
       requirement("mock"),
    ],
)
</code></pre>

the <code>requirement</code> macro will resolve to <code>pip_deps2</code> when
building with <code>--define python=py2</code>, and to <code>pip_deps3</code> when
building with <code>--define python=py3</code>.

Args:
  define: The key of the <code>--define</code> that selects the python version.
  values: For each item in the dict, the key is the value of the <code>--define</code> to match,
          and the value is the name of the pip_import repository rule that provides
          the pip dependencies for that python runtime.
"""


def pip_repositories():
  """Pull in dependencies needed for pulling in pip dependencies.

  A placeholder method that will eventually pull in any dependencies
  needed to install pip dependencies.
  """
  pass
