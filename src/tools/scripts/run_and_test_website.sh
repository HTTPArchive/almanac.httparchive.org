#!/bin/bash

######################################
## Custom Web Almanac script        ##
######################################
#
# This script installs all the required dependencies needed to run the
# Web Almanac website providing you have python and node installed.
#
# It also runs our tests to ensure the website is working for all pages.
#
# It is used by various GitHub actions to build and test the site.
#

# exit when any command fails instead of trying to continue on
set -e

# This script must be run from src directory
if [ -d "src" ]; then
  cd src
fi

echo "Installing and testing python environment"
python -m pip install --upgrade pip
pip install -r requirements.txt
pytest

echo "Installing node modules"
npm install

echo "Building website"
npm run generate

echo "Starting website"
python main.py background &
# Check website is running as won't have got feedback as backgrounded
# use [p]ython so we don't match the grep itself
ps -ef | grep "[p]ython main.py"

echo "Testing website"
npm run test

echo "Website started successfully"
