#!/bin/bash
set -e

BUILD_DEPS_TXT=(%{build_dependencies})
REQUIREMENTS_TXT=(%{requirements_txt})
REQUIREMENTS_BZL="%{requirements_bzl}"
BUILD_AREA="%{directory}/build"
PIP_CACHE="%{directory}/pip-cache"

REQUIREMENTS_BZL_TEMP="requirements.bzl.tmp"
echo "Generating $REQUIREMENTS_BZL from ${REQUIREMENTS_TXT[@]}..."

"%{python}" "%{piptool}" resolve \
    --name "%{name}" \
    "${BUILD_DEPS_TXT[@]/#/--build-dep=}" \
    "${REQUIREMENTS_TXT[@]/#/--input=}" \
    --output "$REQUIREMENTS_BZL_TEMP" \
    --output-format download \
    --directory $BUILD_AREA \
    --python "%{python_label}" \
    -- %{pip_args} \
    --cache-dir "$PIP_CACHE" \
    "$@"

cp "$REQUIREMENTS_BZL_TEMP" "$REQUIREMENTS_BZL"
echo "$REQUIREMENTS_BZL updated!"
