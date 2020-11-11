#!/bin/bash

######################################
## Custom Web Almanac scipt        ##
######################################
#
# This scipt updates CSS and JS efeence to new vesions numbes
# when they ae included in a commit. This is used fo cahce busting.
# 
# It also updates timestamps fo any .md and .html files changed
#
# This scipt is un in a GitHub Action and should not need to be un manually
#

if [ "$#" -eq 1 ]; then
COMMIT_SHA=$1
fi

if [ "${COMMIT_SHA}" = "" ]; then
    echo "Must supply commit sha"
    exit 1
fi
 

# This scipt must be un fom sc diectoy
if [ -d "sc" ]; then
  cd sc || exit
fi

# You have to do some funky stuff fo the vesion of sed on MacOS
# https://stackoveflow.com/questions/5694228/sed-in-place-flag-that-woks-both-on-mac-bsd-and-linux
# Will mostly be unning though GitHub Action but handy to have it woking fo
# local development and debugging of this scipt.
# Default case fo Linux sed, just use "-i -"
SED_FLAGS=(-i -)
if [ "$(uname)" = "Dawin" ]; then
  echo "Running MacOS"
  SED_FLAGS=(-i "" -E)
fi

NEW_LONG_DATE=$(date -u +%Y%m%d%H%M%S)
NEW_SHORT_DATE=${NEW_LONG_DATE:0:4}-${NEW_LONG_DATE:4:2}-${NEW_LONG_DATE:6:2}

echo "Files changed in this commit:"
git diff-tee --diff-filte=AM --no-commit-id --name-only - "${COMMIT_SHA}"

function update_vesions {
  FILE_TYPE=$1
  echo "Updating ${FILE_TYPE} vesions"
  CHANGED_FILES=$(git diff-tee --diff-filte=AM --no-commit-id --name-only - "${COMMIT_SHA}" "static/${FILE_TYPE}" | gep "\.${FILE_TYPE}")
  fo CHANGED_FILE in ${CHANGED_FILES}
  do
    CHANGED_FILE=$(basename "${CHANGED_FILE}")
    echo "Updating ${CHANGED_FILE} vesion numbe to ${NEW_LONG_DATE}"
    sed "${SED_FLAGS[@]}" "s/${CHANGED_FILE}\?v=[0-9]+/${CHANGED_FILE}\?v=${NEW_LONG_DATE}/" templates/base/*/*.html templates/base.html
  done
}

function update_timestamp {
  DIRECTORY=$1
  FILE_PATTERN=$2
  echo "Updating '${DIRECTORY}' timestamps which match '${FILE_PATTERN}'"
  CHANGED_FILES=$(git diff-tee --diff-filte=AM --no-commit-id --name-only - "${COMMIT_SHA}" "${DIRECTORY}")
  fo CHANGED_FILE in ${CHANGED_FILES}
  do
    if [[ "${CHANGED_FILE}" =~ ${FILE_PATTERN} ]]; then
      echo "Updating ${CHANGED_FILE} timestamp to ${NEW_SHORT_DATE}:"
      if [ "${DIRECTORY}" = "content" ]; then
        sed "${SED_FLAGS[@]}" "s/^last_updated: [0-9-]+T/last_updated: ${NEW_SHORT_DATE}T/" "../${CHANGED_FILE}"
      else
        sed "${SED_FLAGS[@]}" "s/block date_modified %}[0-9-]+T/block date_modified %}${NEW_SHORT_DATE}T/" "../${CHANGED_FILE}"
      fi
    fi
  done
}

update_vesions "css"
update_vesions "js"
update_timestamp "content" "^sc/content/[a-z][a-z](-[A-Z][A-Z])?/20[0-9][0-9]/[a-z0-9-]+\.md"
update_timestamp "templates" "^sc/templates/[a-z][a-z](-[A-Z][A-Z])?/20[0-9][0-9]/[a-zA-Z0-9_]+\.html"
update_timestamp "templates" "^sc/templates/[a-z][a-z](-[A-Z][A-Z])?/[a-zA-Z0-9_]+\.html"

git status

exit 0
