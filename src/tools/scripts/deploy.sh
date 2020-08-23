#!/bin/bash

# This script is used to deploy the Web Alamanc to Google Cloud Platform (GCP).
# Users must have push permissions on the production branch and also release
# permissions for the Web Almanac on GCP

# exit when any command fails instead of trying to continue on
set -e

# These color codes allow us to colour text output when used with "echo -e"
RED="\033[0;31m"
GREEN="\033[0;32m"
AMBER="\033[0;33m"
RESET_COLOR="\033[0m" # No Color

# This is a helper function to as if OK to continue with [y/N] answer
function check_continue {
  read -r -n 1 -p "${1} [y/N]: " DEPLOY
  if [ "${DEPLOY}" != "Y" ] && [ "${DEPLOY}" != "y" ]; then
    echo
    echo -e "${RED}Cancelling deploy${RESET_COLOR}"
    exit 1
  else
    echo
  fi
}

echo "Beginning the Web Almanac deployment process"

# Check branch is clean first
if [ -n "$(git status --porcelain)" ]; then 
  check_continue "Your branch is not clean. Do you still want to continue deploying?"
fi

check_continue "Please confirm you've updated the eBooks via GitHub Actions."

echo "Update local production branch"
git checkout production
git status
git pull
git pull origin main

if [ "$(pgrep -f 'python main.py')" ]; then
  echo "Killing existing server to run a fresh version"
  pkill -9 python main.py
fi

echo "Run and test website"
./tools/scripts/run_and_test_website.sh

echo "Please test the site locally"

check_continue "Are you ready to deploy?"

LAST_TAGGED_VERSION=$(git tag -l "v*" | tail)
echo "Last tagged version: ${LAST_TAGGED_VERSION}"
if [[ "${LAST_TAGGED_VERSION}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  SEMVER=( "${LAST_TAGGED_VERSION//./ }" )
  MAJOR="${SEMVER[0]}"
  MINOR="${SEMVER[1]}"
  PATCH="${SEMVER[2]}"
  NEXT_PATCH=$((PATCH + 1))
  NEXT_VERSION="$MAJOR.$MINOR.$NEXT_PATCH"
else
  echo -e "${AMBER}Warning - last tagged version is not of the format vX.X.X!${RESET_COLOR}"
fi

TAG_VERSION=""
while [[ ! "${TAG_VERSION}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]
do
  echo "Please update major tag version when changing default year"
  echo "Please update minor tag version when adding new languages or other large changes"
  read -r -p "Please select tag version of the format vX.X.X. [$NEXT_VERSION]: " TAG_VERSION
done
echo "Tagging as ${TAG_VERSION}"
LONG_DATE=$(date -u +%Y-%m-%d\ %H:%M:%S)
git tag -a "${TAG_VERSION}" -m "Version ${TAG_VERSION} ${LONG_DATE}"
echo "Tagged ${TAG_VERSION} with message 'Version ${TAG_VERSION} ${LONG_DATE}'"

if [[ -f deploy.zip ]]; then
  echo "Removing old deploy.zip"
  rm -f deploy.zip
fi

echo "Zipping artifacts into deploy.zip"
zip -q -r deploy . --exclude @.gcloudignore

echo "Deploying to GCP"
echo "Y" | gcloud app deploy --project webalmanac --stop-previous-version

echo "Push production branch"
git push
git status

echo "Checking out main branch"
git checkout main

echo
echo -e "${GREEN}Successfully deployed!${RESET_COLOR}"
echo
echo -e "${AMBER}Please update release on GitHub: https://github.com/HTTPArchive/almanac.httparchive.org/releases${RESET_COLOR}"
echo -e "Using tag ${TAG_VERSION}@production${RESET_COLOR}"
echo -e "${AMBER}Please upload deploy.zip as the release artifact${RESET_COLOR}"
echo
echo "Have a good one!"
echo
exit 0
