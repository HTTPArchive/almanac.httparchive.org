#!/bin/bash

# Usage info
show_help() {
cat << EOH
Usage: ${0##*/} [-p]
Test that all translations are the same length as the English versions in main branch.
This is a good check to ensure translation is complete and no recent changes have been missed.
If a commit is given then only markdowns changed are tested otherwise all.

    -h   display this help and exit
    -a   test all files
    -v   print extra debug messages
EOH
}

OPTIND=1 # Reseting is good practive
all=0
verbose=0
while getopts "ahv?" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    a)  all=1
        ;;
    v)  verbose=1
        ;;
    esac
done
shift "$((OPTIND-1))" # Discard the options and sentinel --

# This script must be run from src directory
if [ -d "src" ]; then
  cd src || exit
fi

FAILED_FILES=0
FILES_TO_CHECK=""

if [ -d "${GITHUB_WORKSPACE}/original" ]; then
  BASE_FOLDER="${GITHUB_WORKSPACE}/original/src"
  echo "Setting Base folder to: ${BASE_FOLDER}"
else
  BASE_FOLDER="."
  echo "Not using a base folder"
fi

if [ "${all}" == "1" ]; then

    # Get the files that need to be translated
    FILES_TO_CHECK=$(find content templates -name "*.md" -print -o -name "*.html" -not -name "featured_chapters.html" -not -name "ebook.html" -not -path "templates/base.html" -not -path "templates/base/*" -not -path "*/chapters/*" -print)

    if [ "${verbose}" == "1" ]; then
        echo "Comparing the following files:"
        echo "${FILES_TO_CHECK}"
    fi

elif [ "${RUN_TYPE}" == "pull_request" ] && [ "${COMMIT_SHA}" != "" ]; then

    # If this is part of pull request then get list of files as those changed
    # Uses similar logic to GitHub Super Linter (https://github.com/super-linter/super-linter/blob/master/lib/buildFileList.sh)
    # First checkout main to get list of differences
    git pull --quiet
    git checkout main
    # Then get the changes
    FILES_TO_CHECK=$(git diff --name-only "main...${COMMIT_SHA}" --diff-filter=d content templates | sed "s/src\///" | grep -v "templates/base/" | grep -v "templates/base.html" )

    echo "Checking the following files:"
    echo "${FILES_TO_CHECK}"
    # Then back to the pull request changes
    git checkout --progress --force "${COMMIT_SHA}"
fi

function compare_file_lengths {
  FILE_TO_CHECK=$1
  COMPARE_FILE=$2

  if [ "${verbose}" == "1" ]; then
    echo "Comparing ${FILE_TO_CHECK} to ${COMPARE_FILE}..."
  fi
  # Get the two file lengths
  FILE_TO_CHECK_LENGTH=$(wc -l "${FILE_TO_CHECK}" | awk '{ print $1}')
  COMPARE_FILE_LENGTH=$(wc -l "${COMPARE_FILE}" | awk '{ print $1}')
  echo "${FILE_TO_CHECK} ${FILE_TO_CHECK_LENGTH} ${COMPARE_FILE_LENGTH}"
  if [[ "${FILE_TO_CHECK_LENGTH}" != "${COMPARE_FILE_LENGTH}" ]]; then
      FAILED_FILES=$((FAILED_FILES + 1));
      echo "${FILE_TO_CHECK} is ${FILE_TO_CHECK_LENGTH} lines long when ${COMPARE_FILE} is ${COMPARE_FILE_LENGTH}. Please check."
  fi
}

# Test each file
for FILE_TO_CHECK in ${FILES_TO_CHECK}
do

    if [[ "${FILE_TO_CHECK}" != *"/en/"* ]]; then
      # If it's not the English file then find the English file:
      ENGLISH_FILE=$(echo "${FILE_TO_CHECK}" | sed "s/\(.*\)\([content\|templates]\)\/[a-zA-Z-]*\//\1\2\/en\//")
      if [ "${verbose}" == "1" ]; then
          echo "${FILE_TO_CHECK} is a translation of ${ENGLISH_FILE}..."
      fi

      # If the English version is already included in the set of files to check,
      # then compare locally. Otherwise compare to the base directory.
      if [[ "${FILES_TO_CHECK}" == *"${ENGLISH_FILE}"* ]]; then
        COMPARE_FILE="${ENGLISH_FILE}"
      else
        COMPARE_FILE="${BASE_FOLDER}/${ENGLISH_FILE}"
      fi

      compare_file_lengths "${FILE_TO_CHECK}" "${COMPARE_FILE}"

    else

      # If it is English then, should compare all the other translations
      TRANSLATION_FILE_PATTERN=$(echo "${FILE_TO_CHECK}" | sed "s/\(.*\)\\([content\|templates]\)\/en\//\1\2\/*\//")

      # Get a list of files in base folder which match that pattern
      # (local files will already be covered).
      # Disable some shellcheck checks as this is easiest way and it's safe
      # shellcheck disable=SC2010,SC2086
      TRANSLATION_FILES=$(cd "${BASE_FOLDER}" || exit; ls ${TRANSLATION_FILE_PATTERN} | grep -v "/en/" | grep -v "/base/" | sort -u)

      for COMPARE_FILE in ${TRANSLATION_FILES}
      do
        # Only check files that are not in the list of files (as they will be checked anyway)
        if [[ "${FILES_TO_CHECK}" != *"${COMPARE_FILE}"* ]]; then
          compare_file_lengths "${FILE_TO_CHECK}" "${BASE_FOLDER}/${COMPARE_FILE}"
        fi
      done


    fi
done

echo "${FAILED_FILES} failures"
exit ${FAILED_FILES}
