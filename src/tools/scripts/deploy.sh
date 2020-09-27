#!/bin/bash

# This script is used to deploy the Web Alamanc to Google Cloud Platform (GCP).
# Users must have push permissions on the production branch and also release
# permissions for the Web Almanac on GCP

# exit when any command fails instead of trying to continue on
set -e

# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-hv] [-f OUTFILE] [FILE]...
Release the Web Alamanac to Google Cloud Platform
Requires Permissions on Google Cloud Platform for the Web Amanac account

    -h   display this help and exit
    -f   force mode (no interactive prompts for each step)
    -n   no-promote - release a test version
EOF
}

OPTIND=1 #Reseting is good practive
force=0
no_promote=0
while getopts "fn" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    f)  force=1
        ;;
    n)  no_promote=1
        ;;
    esac
done
shift "$((OPTIND-1))" # Discard the options and sentinel --

# These color codes allow us to colour text output when used with "echo -e"
RED="\033[0;31m"
GREEN="\033[0;32m"
AMBER="\033[0;33m"
RESET_COLOR="\033[0m" # No Color

# A helper function to ask if it is OK to continue with [y/N] answer
function check_continue {
  if [ "$force" == "1" ]; then
    return
  fi

  read -r -n 1 -p "${1} [y/N]: " REPLY
  if [ "${REPLY}" != "Y" ] && [ "${REPLY}" != "y" ]; then
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

if [ "${no_promote}" == "0" ]; then
  echo "Update local production branch"
  git checkout production
  git status
  git pull
  git pull origin main
fi

if [ "$(pgrep -f 'python main.py')" ]; then
  echo "Killing existing server to run a fresh version"
  pkill -9 python main.py
fi

echo "Run and test website"
./tools/scripts/run_and_test_website.sh

if [ "${no_promote}" == "1" ]; then
  echo "Deploying to GCP (no promote)"
  echo "Y" | gcloud app deploy --project webalmanac --no-promote
  echo "Done"
  echo "exit 0"
fi

echo "Please test the site locally"

check_continue "Are you ready to deploy?"

LAST_TAGGED_VERSION=$(git tag -l "v*" | tail -1)
echo "Last tagged version: ${LAST_TAGGED_VERSION}"
if [[ "${LAST_TAGGED_VERSION}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  #Split LAST_TAGGED_VERSION on dots (.) into SEMVER
  IFS=\. read -r -a SEMVER <<<"${LAST_TAGGED_VERSION}"
  MAJOR="${SEMVER[0]}"
  MINOR="${SEMVER[1]}"
  PATCH="${SEMVER[2]}"
  NEXT_PATCH=$((PATCH + 1))
  NEXT_VERSION="${MAJOR}.${MINOR}.${NEXT_PATCH}"
else
  echo -e "${AMBER}Warning - last tagged version is not of the format vX.X.X!${RESET_COLOR}"
fi

TAG_VERSION=""
while [[ ! "${TAG_VERSION}" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]
do
  echo "Please update major tag version when changing default year"
  echo "Please update minor tag version when adding new languages or other large changes"
  read -r -p "Please select tag version of the format vX.X.X. [${NEXT_VERSION}]: " TAG_VERSION
  if [[ -z "${TAG_VERSION}" ]]; then
    TAG_VERSION="${NEXT_VERSION}"
  fi
done
check_continue "Tag as ${TAG_VERSION}?"

LONG_DATE=$(date -u +%Y-%m-%d\ %H:%M:%S)
git tag -a "${TAG_VERSION}" -m "Version ${TAG_VERSION} ${LONG_DATE}"
echo "Tagged ${TAG_VERSION} with message 'Version ${TAG_VERSION} ${LONG_DATE}'"

if [[ -f deployed.zip ]]; then
  echo "Removing old deploy.zip"
  rm -f deployed.zip
fi

echo "Zipping artifacts into deploy.zip"
# Exclude chapter images as quite large and tracked in git anyway
zip -q -r deployed . --exclude @.gcloudignore static/images/*/*/* static/pdfs/*

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

if [[ $(which gh) ]]; then
  gh release create "${TAG_VERSION}@production" deployed.zip -t "${TAG_VERSION}"
  echo "Release updated on GitHub"
else
  echo -e "${AMBER}GitHub cli is not available${RESET_COLOR}"
  echo -e "${AMBER}Please update release on GitHub: https://github.com/HTTPArchive/almanac.httparchive.org/releases${RESET_COLOR}"
  echo -e "${AMBER}Using tag ${TAG_VERSION}@production${RESET_COLOR}"
  echo -e "${AMBER}Please upload deploy.zip as the release artifact${RESET_COLOR}"
  echo
fi

echo "Have a good one!"
echo
exit 0
