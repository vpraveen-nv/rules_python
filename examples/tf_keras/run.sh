#!/bin/bash

cp *.txt *.py BUILD fixed/
cp *.txt *.py BUILD original/

echo 'Running standard version'
echo "Will fail because keras didn't depend on tensorflow, so it's not loaded"
cd original
bazel run //:main
cd ..

echo ''
echo '----------------------'
echo ''

echo 'Running standard version'
echo "Will fail because tensorflow uses the purelib format"
cd original
bazel run //:minimal_example
cd ..

echo ''
echo '======================'
echo ''

echo 'Running fixed version'
cd fixed
bazel run //:main
cd ..

echo ''
echo '----------------------'
echo ''

echo 'Running fixed version'
cd fixed
bazel run //:minimal_example
cd ..
