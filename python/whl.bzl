# Copyright 2017 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Import .whl files into Bazel."""

load(
    "@bazel_tools//tools/build_defs/hash:hash.bzl",
    _hash_tools = "tools",
    _sha256 = "sha256",
)

def _extract_wheels(ctx, wheels):
    python = ctx.path(ctx.attr.python) if ctx.attr.python else "python"
    args = [
        python,
        ctx.path(ctx.attr._piptool),
        "extract",
        "--directory", str(ctx.path("")),
        "--repository", ctx.attr.repository,
    ]

    args += ["--whl=%s" % w for w in wheels]
    args += ["--add-dependency=%s" % d for d in ctx.attr.additional_runtime_deps]
    args += ["--drop-dependency=%s" % d for d in ctx.attr.remove_runtime_deps]
    if ctx.attr.additional_build_content:
        args += ["--add-build-content=%s" % ctx.path(ctx.attr.additional_build_content)]
    args += ["--extras=%s" % extra for extra in ctx.attr.extras]

    result = ctx.execute(args, quiet=False)
    if result.return_code:
        fail("extract_wheels failed: %s (%s)" % (result.stdout, result.stderr))

def _build_wheel(ctx):
    env = {}
    python = ctx.path(ctx.attr.python) if ctx.attr.python else "python"

    # Resolve the paths to the dependency wheels to force them to be created.
    # This may cause re-starting this repository rule, see:
    #  https://docs.bazel.build/versions/master/skylark/repository_rules.html#when-is-the-implementation-function-executed
    # We don't actually use the wheels themselves, just their path where the
    # wheel has been extracted (see below).
    paths = [ctx.path(d) for d in ctx.attr.buildtime_deps]

    # Check that python headers are installed. Otherwise some wheels may be built
    # differently depending on the machine..
    result = ctx.execute(["/bin/sh", "-c", "\n".join([
        "INCLUDEPY=$(%s -c \"import sysconfig; print(sysconfig.get_config_vars()['INCLUDEPY'])\")" % python,
        "ls \"$INCLUDEPY/Python.h\""
    ])])
    if result.return_code:
        fail(("Python headers not installed: %s" +
              "If you are using host machine's python interpreter, you may need to install headers from your OS vendor " +
              "(e.g. \"apt-get install python-dev python3-dev\" on Ubuntu).") % result.stderr)

    # Compute a hash from the build time dependencies, and use that in the cache
    # key.  The idea is that if any buildtime dependency changes versions, we will
    # no longer use the same cached wheel.
    hash_input = ':'.join([dep.name for dep in ctx.attr.buildtime_deps])
    cmd = [python, "-c", "import hashlib; print(hashlib.sha256('%s'.encode('utf-8')).hexdigest())" % hash_input]
    result = ctx.execute(cmd)
    if result.return_code:
        fail("failed to compute checksum: %s (%s)" % (result.stdout, result.stderr))
    cache_key = "%s/%s" % (result.stdout.strip(), ctx.attr.wheel_name)

    # Allowing "pip wheel" to download setup_requires packages with easy_install would
    # poke a hole to our wheel version locking scheme, making wheel builds non-deterministic.
    # Disable easy_install as instructed here:
    #   https://pip.pypa.io/en/stable/reference/pip_install/#controlling-setup-requires
    # We set HOME to the current directory so pip will look at this file; see:
    #   https://docs.python.org/2/install/index.html#distutils-configuration-files
    env["HOME"] = str(ctx.path(""))
    ctx.file(".pydistutils.cfg", """[easy_install]
allow_hosts = ''
""")

    # Set PYTHONPATH so that all extracted buildtime dependencies are available.
    root = str(ctx.path("../..")) + '/'
    env["PYTHONPATH"] = ':'.join([root + dep.workspace_root for dep in ctx.attr.buildtime_deps])

    cmd = [
        python,
        ctx.path(ctx.attr._piptool),
        "build",
        "--directory", ctx.path(""),
        "--cache-key", cache_key,
    ]
    cmd += ["--", ctx.attr.requirement]
    cmd += ctx.attr.pip_args
    cmd += ["--no-cache-dir"]
    cmd += ["--no-deps"]
    result = ctx.execute(cmd, quiet=False, environment=env)
    if result.return_code:
        fail("pip wheel failed: %s (%s)" % (result.stdout, result.stderr))

def _download_or_build_wheel_impl(ctx):
    """Core implementation of download_or_build_wheel."""

    if ctx.attr.urls and ctx.attr.requirement:
        fail("only one of urls and requirement should be specified")

    if ctx.attr.urls:
        ctx.download(url=ctx.attr.urls, output=ctx.attr.wheel_name)
    else:
        _build_wheel(ctx)

    result = ctx.execute(["sh", "-c", "ls ./%s" % ctx.attr.wheel_name])
    if result.return_code:
        fail("whl not found: %s (%s)" % (result.stdout, result.stderr))
    ctx.file("BUILD", "")

download_or_build_wheel = repository_rule(
    attrs = {
        "requirement": attr.string(),
        "urls": attr.string_list(),
        "buildtime_deps": attr.label_list(
            allow_files=["*.whl"],
        ),
        "wheel_name": attr.string(),
        "pip_args": attr.string_list(),
        "python": attr.label(
            executable = True,
            cfg = "host",
        ),
        "_piptool": attr.label(
            executable = True,
            default = Label("//tools:piptool.par"),
            cfg = "host",
        ),
    },
    implementation = _download_or_build_wheel_impl,
    environ = ["BAZEL_WHEEL_CACHE"],
)


def _extract_wheels_impl(ctx):
    """Core implementation of extract_wheels."""
    for w in ctx.attr.wheels:
        ctx.symlink(w, w.name)
    _extract_wheels(ctx, [ctx.path(w) for w in ctx.attr.wheels])

extract_wheels = repository_rule(
    attrs = {
        "wheels": attr.label_list(
            allow_files = True,
        ),
        "additional_runtime_deps": attr.string_list(),
        "additional_build_content":  attr.label(allow_single_file=True),
        "remove_runtime_deps": attr.string_list(),
        "repository":  attr.string(),
        "extras": attr.string_list(),
        "python": attr.label(
            executable = True,
            cfg = "host",
        ),
        "_piptool": attr.label(
            executable = True,
            default = Label("//tools:piptool.par"),
            cfg = "host",
        ),
    },
    implementation = _extract_wheels_impl,
)


"""A rule for importing <code>.whl</code> dependencies into Bazel.

<b>This rule is currently used to implement <code>pip_import</code>,
it is not intended to work standalone, and the interface may change.</b>
See <code>pip_import</code> for proper usage.

This rule imports a <code>.whl</code> file as a <code>py_library</code>:
<pre><code>whl_library(
    name = "foo",
    whl = ":my-whl-file",
    repository = "name of pip_import rule",
)
</code></pre>

This rule defines a <code>@foo//:pkg</code> <code>py_library</code> target.

Args:
  whl: The path to the .whl file (the name is expected to follow [this
    convention](https://www.python.org/dev/peps/pep-0427/#file-name-convention))

  requirements: The name of the pip_import repository rule from which to
    load this .whl's dependencies.

  extras: A subset of the "extras" available from this <code>.whl</code> for which
    <code>requirements</code> has the dependencies.
"""
