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
# Note:  we use basic sed with no support for "+" (one or more) and instead
# fake it with syntax like "[0-9][0-9]*" to avoid having to enable extended
# regex which would require more escapes.
#

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

if [ $(uname) = 'Darwin' ]; then
  echo "Running MacOS"
  MACOS=true
fi

NEW_LONG_DATE=`date +%Y%m%d%H%M%S`
NEW_SHORT_DATE=`date '+%Y-%m-%d'`

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
    if [ "${MACOS}" = true ]; then
      sed -i '' s/${CHANGED_FILE}\?v=[0-9][0-9]*/${CHANGED_FILE}\?v=${NEW_LONG_DATE}/ templates/base/*/*.html templates/base.html
    else
      sed -i s/${CHANGED_FILE}\?v=[0-9][0-9]*/${CHANGED_FILE}\?v=${NEW_LONG_DATE}/ templates/base/*/*.html templates/base.html
    fi
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
        if [ "${MACOS}" = true ]; then
          sed -i '' "s/^last_updated: [0-9-][0-9-]*T/last_updated: ${NEW_SHORT_DATE}T/" ../${CHANGED_FILE}
        else
          sed -i "s/^last_updated: [0-9-][0-9-]*T/last_updated: ${NEW_SHORT_DATE}T/" ../${CHANGED_FILE}
        fi
      else
        if [ "${MACOS}" = true ]; then
          sed -i '' "s/block date_modified %}[0-9-][0-9-]*T/block date_modified %}${NEW_SHORT_DATE}T/" ../${CHANGED_FILE}
        else
          sed -i "s/block date_modified %}[0-9-][0-9-]*T/block date_modified %}${NEW_SHORT_DATE}T/" ../${CHANGED_FILE}
        fi
      fi
    fi
  done
}

update_versions "css"
update_versions "js"
update_timestamp "content" "^src/content\/[a-z][a-z](-[A-Z][A-Z])?\/20[0-9]*\/[a-z0-9-]*\.md"
update_timestamp "templates" "^src\/templates\/[a-z][a-z](-[A-Z][A-Z])?\/20[0-9][0-9]\/[a-zA-Z0-9_]*\.html"
update_timestamp "templates" "^src\/templates\/[a-z][a-z](-[A-Z][A-Z])?\/[a-zA-Z0-9_]*\.html"

git status

exit 0
