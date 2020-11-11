#!/bin/bash

######################################
## Custom Web Almanac script        ##
######################################
#
# Run the GitHub Super-Linter locally
# useful to avoid waiting on the push to get feed back
# 
# It can be run to lint everthing if no params are passed
# Or pass one or more params to just lint those files or folders
#

# exit when any command fails instead of trying to continue on
set -e

# This script must be run from src directory
if [ -d "src" ]; then
  cd src
fi

if [ ! "$(which docker)" ]; then
  echo "Docker must be installed to run linter locally"
  exit 1
fi

echo "Installing/Updating Linter (first time this can take a while)"
docker pull github/super-linter:latest

# Annoyingly super-linter includes node_modules and env which take a long time
# so let's copy to /tmp folder and lint from there

# Remove old files if they exist
rm -rf /tmp/lint
mkdir /tmp/lint/

echo "Copying files to /tmp"
# Check if provided files on command line or linting all files
if [ "$#" -gt 0 ]; then
  # Copy linter config files
  mkdir /tmp/lint/.github
  cp -r ../.github/linters /tmp/lint/.github
  # Copy files provided
  for FILES in "$@"
  do
    echo "- Copying ${FILES}"
    cp -r "${FILES}" /tmp/lint
  done
else
  echo "Copying all files"
  # Copy everything and then delete what you don't want linted
  # This is a really inefficient way of doing this but can't find a robust method
  # with MacOs and Linux support, without copying individual folders
  cp -r ../.github /tmp/lint
  cp -r ../src /tmp/lint/
  rm -rf /tmp/lint/src/node_modules
  rm -rf /tmp/lint/src/env
  rm -rf /tmp/lint/src/static/fonts
  rm -rf /tmp/lint/src/static/images
  rm -rf /tmp/lint/src/static/pdfs
fi

echo "Starting linting"
docker run -e RUN_LOCAL=true -e LOG_LEVEL=VERBOSE -e VALIDATE_BASH=true -e VALIDATE_CSS=true -e VALIDATE_HTML=true -e VALIDATE_JAVASCRIPT_ES=true -e VALIDATE_JSON=true -e VALIDATE_MD=true -e VALIDATE_PYTHON_PYLINT=true -e VALIDATE_PYTHON_FLAKE8=true -e VALIDATE_YAML=true -v "/tmp/lint:/tmp/lint" github/super-linter | grep -v "\[DEBUG\]"
