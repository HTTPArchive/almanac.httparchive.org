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

if [ "$(pgrep -f 'python main.py')" ]; then
  echo "Killing existing server to run a fresh version"
  pkill -9 python main.py
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
# Sleep for a couple of seconds to make sure server is up
sleep 2
# Check website is running as won't have got feedback as backgrounded
pgrep -f "python main.py"

echo "Testing website"
npm run test

echo "Monitoring templates for changes"
npm run watch &

echo "Website started successfully"
