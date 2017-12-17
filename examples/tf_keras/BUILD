load("@pip_deps//:requirements.bzl", "requirement")

py_binary(
    name = 'main',
    srcs = ['main.py'],
    main = 'main.py',
    deps = [
        requirement('pyyaml'),
        requirement('keras'),
#        requirement('tensorflow-gpu'),
    ]
)

py_binary(
        name = 'minimal_example',
        srcs = ['minimal_example.py'],
        deps = [
                requirement('tensorflow-gpu'),
        ]
)
