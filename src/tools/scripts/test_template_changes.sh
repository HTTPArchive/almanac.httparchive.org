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
DIFF_FILENAME=/tmp/template_differences.txt

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
#Don't fail if there are differences so turn that check off that temporarily
set +e
echo "Files that are different:"
diff -r templates "${TEMP_TEMPLATES_DIRECTORY}"
echo "Line differences:"
diff -r templates "${TEMP_TEMPLATES_DIRECTORY}" > "${DIFF_FILENAME}"
set -e

echo "Differences:"
cat "${DIFF_FILENAME}"

NUM_DIFFS=$(wc -l < "${DIFF_FILENAME}")
if [ "${NUM_DIFFS}" -ne "0" ]; then
  # Weird syntax is to make is Mac compatible: https://stackoverflow.com/a/1252191/2144578
  ESCAPED_OUTPUT=$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\%/%25/g' -e 's/\n/%0A/g' -e 's/\r/%0D/g' -e "s/'/%27/g" -e 's/"/%22/g' "${DIFF_FILENAME}")
  PR_COMMENT="Please note, that the following diffs happen in the templates on this branch compared to main:%0A\`\`\`%0A${ESCAPED_OUTPUT}%0A\`\`\`%0A"
  echo "PR_COMMENT=${PR_COMMENT}" >> "$GITHUB_ENV"
fi

echo "Removing templates backup"
rm -rf "${TEMP_TEMPLATES_DIRECTORY}"
rm -f "${DIFF_FILENAME}"

echo "Comparison complete"
