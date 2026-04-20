#!/bin/sh

FILES=$(find -name '*.nix')

for test in $FILES; do
        nixfmt -s $test
done
echo Done!
