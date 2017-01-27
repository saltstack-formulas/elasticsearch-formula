#!/bin/sh

rm -rf vendor
mkdir vendor
cd vendor
git clone https://github.com/saltstack-formulas/sun-java-formula
cd ..
gem list
bundle exec kitchen verify
