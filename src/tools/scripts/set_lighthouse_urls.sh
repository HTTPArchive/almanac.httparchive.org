#!/bin/bash

# exit when any command fails instead of trying to continue on
set -e

LIGHTHOUSE_CONFIG_FILE="../.github/lighthouse/lighthouse-config.json"

# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-p]
Get a list of URLs to run a lighthouse test on

    -h   display this help and exit
    -p   get all production URLs from sitemap.xml
EOF
}

OPTIND=1 # Reseting is good practive
production=0
while getopts "h?p" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    p)  production=1
        ;;
    esac
done
shift "$((OPTIND-1))" # Discard the options and sentinel --

# This script must be run from src directory
if [ -d "src" ]; then
  cd src || exit
fi

SED_FLAGS=(-i -e)
if [ "$(uname)" = "Darwin" ]; then
  echo "Running MacOS"
  SED_FLAGS=(-i "" -e)
fi

LIGHTHOUSE_URLS=""

# Set some URLs that should always be checked on pull requests
# to ensure basic coverage
BASE_URLS=$(cat <<-END
    http://localhost:8080/en/2019/
    http://localhost:8080/en/2019/css
    http://localhost:8080/en/2020/
END
)
# Strip spaces
BASE_URLS=$(echo "${BASE_URLS}" | sed 's/ *//g')

if [ "${production}" == "1" ]; then
    # Get the production URLs from the production sitemap
    LIGHTHOUSE_URLS=$(curl -s https://almanac.httparchive.org/sitemap.xml | grep "<loc" | grep -v static | sed 's/ *<loc>//g' | sed 's/<\/loc>//g')
elif [ "${COMMIT_SHA}" != "" ]; then
    # If this is part of pull request then get list of files as those changed
    CHANGED_FILES=$(git diff-tree --diff-filter=AM --no-commit-id --name-only -r "${COMMIT_SHA}" "content/")
    LIGHTHOUSE_URLS=$(echo "${CHANGED_FILES}" | sed 's/src\/content/http:\/\/localhost:8080/g' )
    if [ "${LIGHTHOUSE_URLS}" = "" ]; then
        LIGHTHOUSE_URLS="${BASE_URLS}"
    else
        LIGHTHOUSE_URLS=$( echo -e "${LIGHTHOUSE_URLS}\n${BASE_URLS}")
    fi
else
    # Else test every URL (except PDFs) in sitemap
    LIGHTHOUSE_URLS=$(grep loc templates/sitemap.xml | grep -v static | sed 's/ *<loc>//g' | sed 's/<\/loc>//g' | sed 's/https:\/\/almanac.httparchive.org/http:\/\/localhost/g')
fi

# Format the URLs for the lighthouse config:
LIGHTHOUSE_URLS=$(echo "${LIGHTHOUSE_URLS}" | sed 's/^/          "/' | sed 's/$/",/')
LIGHTHOUSE_URLS=${LIGHTHOUSE_URLS:0:${#LIGHTHOUSE_URLS}-1}

# Take all but the first two lines of the existing config
# So as to maintain assertions
LIGHTHOUSE_CONFIG=$(cat ${LIGHTHOUSE_CONFIG_FILE} | sed 1,2d)

#
cat > "${LIGHTHOUSE_CONFIG_FILE}" << END_CONFIG
{
  "ci": {
    "collect": {
      "url": [
${LIGHTHOUSE_URLS}
      ]
    },
${LIGHTHOUSE_CONFIG}
END_CONFIG

#echo 'LIGHTHOUSE_URLS="${LIGHTHOUSE_URLS}"' >> $GITHUB_ENV
