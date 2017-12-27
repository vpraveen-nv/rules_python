#!/bin/bash

cp *.txt *.py fixed/
cp *.txt *.py original/

echo 'Running standard version'
echo "Will fail because google packages rely on name collision when placing the modules in dirs"
cd original
bazel run //:example
cd ..

echo ''
echo '======================'
echo ''

echo 'Running fixed version'
cd fixed
bazel run //:example
cd ..
