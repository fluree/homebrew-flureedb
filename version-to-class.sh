#!/usr/bin/env bash

set -e

version=$1

mkdir -p .tmp

echo "class Flureedb < Formula; end" > .tmp/flureedb@${version}.rb

class=$(brew audit .tmp/flureedb@${version}.rb 2>&1 | grep 'Expected to find' | awk '{print $4 " " $5}' | cut -d, -f1)

echo $class

rm -rf .tmp
