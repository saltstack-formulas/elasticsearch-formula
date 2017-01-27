#!/bin/bash
set -ev

rm -rf vendor
mkdir vendor
cd vendor
git clone https://github.com/saltstack-formulas/sun-java-formula
cd ..
bundle exec kitchen verify
