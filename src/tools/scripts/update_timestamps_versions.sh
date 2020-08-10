#!/bin/bash

######################################
## Custom Web Almanac script        ##
######################################
#
# This script updates CSS and JS reference to new versions numbers
# when they are included in a commit. This is used for cahce busting.
# 
# It also updates timestamps for any .md and .html files changed
#
# This script is run in a GitHub Action and should not need to be run manually
#

# echo commands to screen for debugging
set -x

if [ "$#" -eq 1 ]; then
COMMIT_SHA=$1
fi

if [ "{COMMIT_SHA}" = "" ]; then
    echo "Must supply commit sha"
    exit 1
fi
 

# This script must be run from src directory
if [ -d "src" ]; then
  cd src
fi

# You have to do some funky stuff for the version of sed on MacOS
# https://stackoverflow.com/questions/5694228/sed-in-place-flag-that-works-both-on-mac-bsd-and-linux
# Will mostly be running through GitHub Action but handy to have it working for
# local development and debugging of this script.
# Default case for Linux sed, just use "-i -r"
SED_FLAGS=(-i -r)
if [ $(uname) = 'Darwin' ]; then
  echo "Running MacOS"
  SED_FLAGS=(-i "" -E)
fi

NEW_LONG_DATE=`date -u +%Y%m%d%H%M%S`
NEW_SHORT_DATE=${NEW_LONG_DATE:0:4}-${NEW_LONG_DATE:4:2}-${NEW_LONG_DATE:6:2}

echo "Files changed in this commit:"
git diff-tree --diff-filter=AM --no-commit-id --name-only -r ${COMMIT_SHA}

function update_versions {
  FILE_TYPE=$1
  echo "Updating ${FILE_TYPE} versions"
  CHANGED_FILES=`git diff-tree --diff-filter=AM --no-commit-id --name-only -r ${COMMIT_SHA} static/${FILE_TYPE} | grep "\.${FILE_TYPE}"`
  for CHANGED_FILE in ${CHANGED_FILES}
  do
    CHANGED_FILE=`basename ${CHANGED_FILE}`
    echo "Updating ${CHANGED_FILE} version number to ${NEW_LONG_DATE}"
    sed "${SED_FLAGS[@]}" "s/${CHANGED_FILE}\?v=[0-9]+/${CHANGED_FILE}\?v=${NEW_LONG_DATE}/" templates/base/*/*.html templates/base.html
  done
}

function update_timestamp {
  DIRECTORY=$1
  FILE_PATTERN=$2
  echo "Updating '${DIRECTORY}' timestamps which match '${FILE_PATTERN}'"
  CHANGED_FILES=`git diff-tree --diff-filter=AM --no-commit-id --name-only -r ${COMMIT_SHA} ${DIRECTORY}`
  for CHANGED_FILE in ${CHANGED_FILES}
  do
    if [[ "${CHANGED_FILE}" =~ ${FILE_PATTERN} ]]; then
      echo "Updating ${CHANGED_FILE} timestamp to ${NEW_SHORT_DATE}:"
      if [ "${DIRECTORY}" = "content" ]; then
        sed "${SED_FLAGS[@]}" "s/^last_updated: [0-9-]+T/last_updated: ${NEW_SHORT_DATE}T/" ../${CHANGED_FILE}
      else
        sed "${SED_FLAGS[@]}" "s/block date_modified %}[0-9-]+T/block date_modified %}${NEW_SHORT_DATE}T/" ../${CHANGED_FILE}
      fi
    fi
  done
}

update_versions "css"
update_versions "js"
update_timestamp "content" "^src/content/[a-z][a-z](-[A-Z][A-Z])?/20[0-9][0-9]/[a-z0-9-]+\.md"
update_timestamp "templates" "^src/templates/[a-z][a-z](-[A-Z][A-Z])?/20[0-9][0-9]/[a-zA-Z0-9_]+\.html"
update_timestamp "templates" "^src/templates/[a-z][a-z](-[A-Z][A-Z])?/[a-zA-Z0-9_]+\.html"

git status

exit 0
