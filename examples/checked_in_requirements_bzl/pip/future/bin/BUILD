load("@examples_checked_in_requirements_bzl//:requirements.bzl", "requirement")
load("@rules_python//python:defs.bzl", "py_entrypoint_binary")

package(default_visibility = ["//visibility:public"])

py_entrypoint_binary(
    name = "futurize",
    entrypoint = "libfuturize.main:main",
    deps = [requirement("future")],
)

py_entrypoint_binary(
    name = "pasteurize",
    entrypoint = "libpasteurize.main:main",
    deps = [requirement("future")],
)
