#!/bin/sh

set -x

env
rm -rf vendor
mkdir vendor
cd vendor
git clone https://github.com/saltstack-formulas/sun-java-formula
cd ..
env
bundle exec kitchen verify
