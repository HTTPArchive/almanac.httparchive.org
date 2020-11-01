#!/bin/bash

# debug
set -x

LIGHTHOUSE_CONFIG_FILE="../.github/lighthouse/lighthouse-config-dev.json"
LIGHTHOUSE_PROD_CONFIG_FILE="../.github/lighthouse/lighthouse-config-prod.json"

# Usage info
show_help() {
cat << EOH
Usage: ${0##*/} [-p]
Get a list of URLs to run a lighthouse test on

    -h   display this help and exit
    -p   get all production URLs from sitemap.xml
EOH
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

LIGHTHOUSE_URLS=""

# Set some URLs that should always be checked on pull requests
# to ensure basic coverage
BASE_URLS=$(cat <<-END
http://127.0.0.1:8080/en/2019/
http://127.0.0.1:8080/en/2019/javascript
http://127.0.0.1:8080/en/2020/
END
)

if [ "${production}" == "1" ]; then
    # Get the production URLs from the production sitemap
    LIGHTHOUSE_URLS=$(curl -s https://almanac.httparchive.org/sitemap.xml | grep "<loc" | grep -v static | sed 's/ *<loc>//g' | sed 's/<\/loc>//g')
    LIGHTHOUSE_CONFIG_FILE="${LIGHTHOUSE_PROD_CONFIG_FILE}"
elif [ "${RUN_TYPE}" != "workflow_dispatch" ] && [ "${COMMIT_SHA}" != "" ]; then
    # If this is part of pull request then get list of files as those changed
    CHANGED_FILES=$(git diff --diff-filter=d --no-commit-id --name-only "main...${GITHUB_SHA}" content templates | grep -v base.html | grep -v ejs | grep -v base_ | grep -v toc.html | grep -v sitemap)

    LIGHTHOUSE_URLS=$(echo "${CHANGED_FILES}" | sed 's/src\/content/http:\/\/127.0.0.1:8080/g' | sed 's/\.md//g' | sed 's/\/base\//\/en\//g' | sed 's/src\/templates/http:\/\/127.0.0.1:8080/g' | sed 's/\.html//g' | sed 's/_/-/g' | sed 's/\/2019\/accessibility-statement/\/accessibility-statement/g' )
    if [ "${LIGHTHOUSE_URLS}" = "" ]; then
        LIGHTHOUSE_URLS="${BASE_URLS}"
    else
        LIGHTHOUSE_URLS=$( echo -e "${LIGHTHOUSE_URLS}\n${BASE_URLS}")
    fi
else
    # Else test every URL (except PDFs) in sitemap
    LIGHTHOUSE_URLS=$(grep loc templates/sitemap.xml | grep -v static | sed 's/ *<loc>//g' | sed 's/<\/loc>//g' | sed 's/https:\/\/almanac.httparchive.org/http:\/\/127.0.0.1:8080/g')
fi

echo "URLS to check:"
echo "${LIGHTHOUSE_URLS}"

# Format the URLs for the lighthouse config:
LIGHTHOUSE_URLS=$(echo "${LIGHTHOUSE_URLS}" | sed 's/^ */          "/' | sed 's/$/",/')
LIGHTHOUSE_URLS=${LIGHTHOUSE_URLS:0:${#LIGHTHOUSE_URLS}-1}

# Take all but the first two lines of the existing config
# So as to maintain assertions
LIGHTHOUSE_CONFIG=$(sed "1,2d" ${LIGHTHOUSE_CONFIG_FILE})

# Write the new config file - inclduing the URLs
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
