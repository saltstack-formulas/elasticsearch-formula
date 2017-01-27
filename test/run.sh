#!/bin/sh

rm -rf vendor
mkdir vendor
cd vendor
git clone https://github.com/saltstack-formulas/sun-java-formula
cd ..
BUNDLE_PATH=vendor/bundle bundle exec kitchen verify
