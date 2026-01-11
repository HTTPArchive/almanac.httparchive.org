#!/bin/bash

LIGHTHOUSE_CONFIG_FILE="../.github/lighthouse/lighthouse-config-dev.json"
LIGHTHOUSE_PROD_CONFIG_FILE="../.github/lighthouse/lighthouse-config-prod.json"

# Usage info
show_help() {
cat << EOH
Usage: ${0##*/} [-p]
Get a list of URLs to run a lighthouse test on.
If a commit is given then only URLs changes are tested otherwise all.

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
# We exclude webmentions to avoid Lighthouse issues
BASE_URLS=$(cat <<-END
http://127.0.0.1:8080/en/2019/?nowebmentions
http://127.0.0.1:8080/en/2019/javascript?nowebmentions
http://127.0.0.1:8080/en/2020/?nowebmentions
http://127.0.0.1:8080/en/2020/css?nowebmentions
http://127.0.0.1:8080/en/2021/?nowebmentions
http://127.0.0.1:8080/en/2021/third-parties?nowebmentions
http://127.0.0.1:8080/en/2022/?nowebmentions
http://127.0.0.1:8080/en/2022/javascript?nowebmentions
http://127.0.0.1:8080/en/2024/?nowebmentions
http://127.0.0.1:8080/en/2024/accessibility?nowebmentions
http://127.0.0.1:8080/en/2025/?nowebmentions
END
)

if [ "${production}" == "1" ]; then

    # Get the production URLs from the production sitemap (except PDFs and Stories)
    LIGHTHOUSE_URLS=$(curl -s https://almanac.httparchive.org/sitemap.xml | grep "<loc" | grep -v "/static/" | grep -v stories | sed 's/ *<loc>//g' | sed 's/<\/loc>//g' | sed 's/$/?nowebmentions/g' )

    # Temporarily remove chapters failing in Lighthouse - TODO Try removing this on next Lighthouse upgrade
    #LIGHTHOUSE_URLS=$(echo "${LIGHTHOUSE_URLS}" | grep -v "/en/2021/cdn" | grep -v '/2021/ecommerce')

    # Switch to the Production Config file
    LIGHTHOUSE_CONFIG_FILE="${LIGHTHOUSE_PROD_CONFIG_FILE}"

elif [ "${RUN_TYPE}" == "pull_request" ] && [ "${COMMIT_SHA}" != "" ]; then

    # If this is part of pull request then get list of files as those changed
    # Uses similar logic to GitHub Super Linter (https://github.com/super-linter/super-linter/blob/master/lib/buildFileList.sh)
    # First checkout main to get list of differences
    git pull --quiet
    git checkout main
    # Then get the changes
    CHANGED_FILES=$(git diff --name-only "main...${COMMIT_SHA}" --diff-filter=d content templates | grep -v base.html | grep -v ejs | grep -v base_ | grep -v sitemap | grep -v error.html | grep -v stories | grep -v embed.html | grep -v "/embeds/" )
    echo "Changed files: ${CHANGED_FILES}"

    # Then back to the pull request changes
    git checkout --progress --force "${COMMIT_SHA}"

    # Transform the files to http://127.0.0.1:8080 URLs
    LIGHTHOUSE_URLS=$(echo "${CHANGED_FILES}" | sed 's/src\/content/http:\/\/127.0.0.1:8080/g' | sed 's/\.md//g' | sed 's/\/base\//\/en\/2019\//g' | sed 's/src\/templates/http:\/\/127.0.0.1:8080/g' | sed 's/index\.html//g' | sed 's/\.html//g' | sed 's/_/-/g' | sed 's/\/2019\/accessibility-statement/\/accessibility-statement/g' | sed 's/\/2019\/search/\/search/g' | sed -E 's/(http:\/\/.*)$/\1?nowebmentions/g' )
    echo "URLs to test: ${LIGHTHOUSE_URLS}"

    # Temporarily remove chapters failing in Lighthouse - TODO Try removing this on next Lighthouse upgrade
    # LIGHTHOUSE_URLS=$(echo "${LIGHTHOUSE_URLS}" | grep -v "/en/2021/cdn" | grep -v '/2021/ecommerce')

    # Add base URLs and strip out newlines
    LIGHTHOUSE_URLS=$(echo -e "${LIGHTHOUSE_URLS}\n${BASE_URLS}" | sort -u | sed '/^$/d')

else

    # Else test every URL (except PDFs and Stories) in the sitemap
    LIGHTHOUSE_URLS=$(grep loc templates/sitemap.xml | grep -v "/static/" | grep -v stories | sed 's/ *<loc>//g' | sed 's/<\/loc>//g' | sed 's/https:\/\/almanac.httparchive.org/http:\/\/127.0.0.1:8080/g' | sed 's/$/?nowebmentions/g' )

    # Temporarily remove chapters failing in Lighthouse - TODO Try removing this on next Lighthouse upgrade
    #LIGHTHOUSE_URLS=$(echo "${LIGHTHOUSE_URLS}" | grep -v "/en/2021/cdn" | grep -v '/2021/ecommerce')
fi

echo "URLS to check:"
echo "${LIGHTHOUSE_URLS}"

# Use jq to insert the URLs into the config file:
LIGHTHOUSE_CONFIG_WITH_URLS=$(echo "${LIGHTHOUSE_URLS}" | jq -Rs '. | split("\n") | map(select(length > 0))' | jq -s '.[0] * {ci: {collect: {url: .[1]}}}' "${LIGHTHOUSE_CONFIG_FILE}" -)

echo "${LIGHTHOUSE_CONFIG_WITH_URLS}" > "${LIGHTHOUSE_CONFIG_FILE}"
