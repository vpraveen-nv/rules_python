load(
    "@io_bazel_rules_python//python:whl.bzl",
    _wheel_rules = "wheel_rules",
    _download_or_build_wheel = "download_or_build_wheel",
    _extract_wheel = "extract_wheel",
)
load("@%{repo}//:requirements.gen.bzl", _wheels = "wheels")

_pip_args = [%{pip_args}]
_python = "%{python}" or None
_repository = "%{repo}"
_additional_attributes = %{additional_attributes}

def _merged_wheels():
    default_attrs = {
        "repository": _repository,
        "pip_args": _pip_args,
        "python": _python,
    }
    return {k: v + default_attrs + _additional_attributes.get(k, {}) for k, v in _wheels.items()}

wheels = _merged_wheels()

def requirement(name, target = "pkg", binary = None):
    # Handle extras
    parts = name.split("[")
    name = parts[0]
    if len(parts) > 1:
        target = parts[1].rstrip("]")
    key = name.lower()
    if key not in wheels:
        fail("Could not find pip-provided dependency: '%s'" % name)
    if binary:
        return "@%s//:%s" % (wheels[key]["name"], "entrypoint_" + binary)
    return "@%s//:%s" % (wheels[key]["name"], target)

def pip_install():
    for distribution, attributes in wheels.items():
        wheel = attributes.get("wheel", None)
        if not wheel:
            wheel = download_or_build_wheel(distribution = distribution)
        extract_wheel(wheel = wheel, distribution = distribution)

def _wheel_target(w):
    return "@%s_wheel//:%s" % (w["name"], w["wheel_name"])

def _build_deps(k):
    wheel = wheels[k]
    buildtime_deps = {}
    for d in wheel.get("additional_buildtime_deps", []):
        buildtime_deps += {d: None} + {k: None for k in wheels[d].get("transitive_runtime_deps", [])}
    return buildtime_deps.keys()

def download_or_build_wheel(distribution, rule=_download_or_build_wheel, **kwargs):
    w = wheels[distribution]
    attrs = {a: w.get(a, None) for a in _wheel_rules.download_or_build_wheel.attrs}
    attrs["distribution"] = distribution
    attrs["buildtime_deps"] = [_wheel_target(wheels[k]) for k in _build_deps(distribution)]
    rule(
        name = "%s_wheel" % w["name"],
        **attrs + kwargs
    )
    return _wheel_target(w)

def extract_wheel(wheel, distribution, rule=_extract_wheel, **kwargs):
    w = wheels[distribution]
    attrs = {a: w.get(a, None) for a in _wheel_rules.extract_wheel.attrs}
    attrs["wheel"] = wheel
    rule(
        name = w["name"],
        **attrs + kwargs
    )

info = struct(
    wheels = wheels,
    download_or_build_wheel = download_or_build_wheel,
    extract_wheel = extract_wheel,
)
