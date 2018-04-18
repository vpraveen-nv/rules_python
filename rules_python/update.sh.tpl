#!/bin/sh
set -e

REQUIREMENTS_TXT="%{requirements_txt}"
REQUIREMENTS_BZL="%{requirements_bzl}"
BUILD_AREA="%{directory}/build"

if [ -z "$REQUIREMENTS_BZL" ]; then
    REQUIREMENTS_BZL=$(dirname $(realpath "$REQUIREMENTS_TXT"))/requirements.bzl
fi
REQUIREMENTS_BZL_TEMP="requirements.bzl.tmp"
echo "Generating $REQUIREMENTS_BZL from $REQUIREMENTS_TXT..."

rm -rf "$BUILD_AREA"

python "%{piptool}" resolve \
    --name "%{name}" \
    --input "$REQUIREMENTS_TXT" \
    --output "$REQUIREMENTS_BZL_TEMP" \
    --output-format download \
    --directory $BUILD_AREA \
    -- %{pip_args} \
    --no-cache-dir

cp "$REQUIREMENTS_BZL_TEMP" "$REQUIREMENTS_BZL"
echo "$REQUIREMENTS_BZL updated!"
