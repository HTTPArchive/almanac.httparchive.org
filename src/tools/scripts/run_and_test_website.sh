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

# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-hd]
This script installs all the required dependencies needed to run the
Web Almanac website providing you have python and node installed.

    -h   display this help and exit
    -d   debug mode (watches files for changes)
EOF
}

OPTIND=1 #Reseting is good practive
debug=0
while getopts "h?d" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    d)  debug=1
        ;;
    esac
done
shift "$((OPTIND-1))" # Discard the options and sentinel --

# This script must be run from src directory
if [ -d "src" ]; then
  cd src
fi

if [ "$(pgrep -f 'python main.py')" ]; then
  echo "Killing existing server to run a fresh version"
  pkill -9 -f "python main.py"
fi

if [ "$(pgrep -f 'node ./tools/generate/chapter_watcher')" ]; then
  echo "Killing existing watcher to run a fresh version"
  pkill -9 -f "node ./tools/generate/chapter_watcher"
fi

echo "Installing and testing python environment"
python -m pip install --upgrade pip
pip install -r requirements.txt

echo "Starting website in background mode for tests"
python main.py background &
# Sleep for a couple of seconds to make sure server is up
sleep 2
# Check website is running as won't have got feedback as backgrounded
pgrep -f "python main.py"

echo "Installing node modules"
npm install

echo "Building website"
npm run generate

echo "Running pytest"
npm run pytest

echo "Testing website"
npm run test

# If being run in GitHub actions then generating the website should not
# change any Git-tracked files. If it does then it suggests something's
# wrong. Exit
if [ "${GITHUB_ACTIONS}" ] && [ -n "$(git status --porcelain)" ]; then
  echo "Generating the website produced a different file than is in the branch"
  git status
  exit 1
fi

echo "Website started successfully"

# If in debug more then restart server in debug mode so it picks up new files
# Annoyingly Flask doesn't like backgrounding debug mode immeadiately
# So need to run debug mode at end without backgrounding
if [ "${debug}" == "1" ]; then

  echo "Monitoring templates for changes"
  npm run watch &

  if [ "$(pgrep -f 'python main.py')" ]; then
    echo "Killing server to run a fresh version in debug mode"
    pkill -9 -f "python main.py"
  fi

  echo "Starting website in foreground mode so it reloads on file changes"
  python main.py

fi
