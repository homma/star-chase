#!/bin/sh -x

ROOT_DIR=$(dirname $0)/..

cd ${ROOT_DIR}

rm project.godot
touch project.godot

rm -rf .godot
rm *.tscn
find . -name '*.uid' -exec rm {} \;
