load("@io_bazel_rules_python//python:whl.bzl", "download_or_build_wheel", "extract_wheels")

_additional_buildtime_deps = {%{additional_buildtime_deps}
}
_additional_runtime_deps = {%{additional_runtime_deps}
}

def _wheel(wheels_map, name):
  name_key = name.split("[")[0] # Strip extra
  if name_key not in wheels_map:
    fail("Could not find wheel: '%s'" % name)
  return wheels_map[name_key]

def _wheels(wheels_map, names):
  return [_wheel(wheels_map, n) for n in names]

def whl_library(name, wheels_map={}, requirement=None, whl=None, runtime_deps=[], extras=[]):
    repository = "%{repo}"
    dirty_repo_name = "%s_dirty" % name
    wheel_repo_name = "%s_wheel" % name
    key = requirement.split("==")[0]
    buildtime_deps = _additional_buildtime_deps.get(key, [])
    additional_runtime_deps = _additional_runtime_deps.get(key, [])
    wheel_name = _wheel(wheels_map, key).split(":")[1]
    if name not in native.existing_rules():
        if whl:
            extract_wheels(
                name = name,
                wheels = [whl],
                additional_runtime_deps = additional_runtime_deps,
                repository = "%{repo}",
                extras = extras,
            )
        else:
            download_or_build_wheel(
                name = wheel_repo_name,
                requirement = requirement,
                wheel_name = wheel_name,
                buildtime_deps = _wheels(wheels_map, buildtime_deps),
                pip_args = [%{pip_args}],
            )
            extract_wheels(
                name = name,
                wheels = ["@%s//:%s" % (wheel_repo_name, wheel_name)],
                additional_runtime_deps = additional_runtime_deps,
                repository = "%{repo}",
                extras = extras,
            )

    if dirty_repo_name not in native.existing_rules():
        extract_wheels(
            name = dirty_repo_name,
            wheels = [_wheel(wheels_map, key)] + _wheels(wheels_map, runtime_deps),
            additional_runtime_deps = additional_runtime_deps,
            repository = "%{repo}",
            extras = extras,
        )
