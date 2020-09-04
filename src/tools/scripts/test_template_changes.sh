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

TEMP_TEMPLATES_DIRECTORY=templates_new
TEMP_DIFF_FILENAME=/tmp/template_differences.txt

# This script must be run from src directory
if [ -d "src" ]; then
  cd src
fi

if [ -d "${TEMP_TEMPLATES_DIRECTORY}" ]; then
  echo "${TEMP_TEMPLATES_DIRECTORY} already exists. Exiting"
  exit 1
fi

echo "Installing node modules"
npm install

echo "Building website"
npm run generate

echo "Backing up templates"
cp -r templates "${TEMP_TEMPLATES_DIRECTORY}"

echo "Checkout main branch"
git checkout main

echo "Reinstalling node modules"
rm -rf node_modules
npm install

echo "Building website"
npm run generate

echo "Diff the two folders"
#Don't fail if there are differences so turn off that temporarily
set +e
diff -r templates "${TEMP_TEMPLATES_DIRECTORY}" > "${TEMP_DIFF_FILENAME}"
set -e

echo "Differences:"
DIFFERENCES=$(cat "${TEMP_DIFF_FILENAME}")
echo "${DIFFERENCES}"

NUM_DIFFS=$(wc -l < "${TEMP_DIFF_FILENAME}")
if [ "${NUM_DIFFS}" -ne "0" ]; then
  PR_COMMENT="The following diffs happen in the templates due to differences in this branch and main:%0A\`\`\`%0A${DIFFERENCES}%0A\`\`\`%0A"
  echo "::set-env name=PR_COMMENT::${PR_COMMENT}"
fi

echo "Removing templates backup"
rm -rf "${TEMP_TEMPLATES_DIRECTORY}"

echo "Comparison complete"
