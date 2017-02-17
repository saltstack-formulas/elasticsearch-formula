#!/bin/bash
set -ev

git clone https://github.com/saltstack-formulas/sun-java-formula vendor/sun-java-formula
bundle exec kitchen verify
