def python_rules_dependencies():
    pass

def _python_toolchain_repository_impl(ctx):
    ctx.symlink(ctx.attr.path, "bin/python")
    ctx.file("BUILD", """\
package(default_visibility = ["//visibility:public"])
exports_files(["bin/python"])
""")

_python_toolchain_repository = repository_rule(
    implementation = _python_toolchain_repository_impl,
    attrs = {
        "path": attr.string(mandatory=True),
    },
)

def python_toolchain_repository(name, path):
    _python_toolchain_repository(
        name = name,
        path = path,
    )
