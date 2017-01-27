#!/bin/sh

rm -rf vendor
mkdir vendor
cd vendor
git clone https://github.com/saltstack-formulas/sun-java-formula
cd ..
bundle exec --path vendor/bundle kitchen verify
