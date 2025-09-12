#!/bin/bash

# This script is used to deploy the Web Almanac to Google Cloud Platform (GCP).
# Users must have the following permissions:
# - push permissions on the production branch,
# - Github permissions to download the latest e-books from Github Action artifacts,
# - release permissions for the Web Almanac on GCP

# exit when any command fails instead of trying to continue on
set -e

# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-hv] [-u URL]...
Release the Web Alamanac to Google Cloud Platform
Requires Permissions on Google Cloud Platform for the Web Amanac account

    -h   display this help and exit
    -f   force mode (no interactive prompts for each step)
    -n   no-promote - release a test version
    -s   stage version to use (e.g. 20211111t105151)
EOF
}

OPTIND=1 #Reseting is good practive
force=0
no_promote=0
while getopts ":h?fns:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    f)  force=1
        ;;
    n)  no_promote=1
        ;;
    s)  STAGE_VERSION=${OPTARG}
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

if [ ! "$(which pgrep)" ]; then
  echo "Need pgrep installed. Try 'brew install proctools'"
  exit 1
fi

echo "Beginning the Web Almanac deployment process"

# This script must be run from src directory
if [ -d "src" ]; then
  cd src
fi

if [ "${no_promote}" == "1" ]; then
  echo "Deploying to GCP (no promote)"
  if [[ -z "${STAGE_VERSION}" ]]; then
    echo "Y" | gcloud app deploy --project webalmanac --no-promote
  else
    echo "Y" | gcloud app deploy --project webalmanac --no-promote --version="${STAGE_VERSION}"
  fi
  echo "Done"
  exit 0
fi

# Check branch is clean first
if [ -n "$(git status --porcelain)" ]; then
  check_continue "Your branch is not clean. Do you still want to continue deploying?"
fi

check_continue "Please confirm you've run the pre-deploy script via GitHub Actions."

echo "Update local production branch"
git checkout production
git status
git pull
git pull origin main

if [ "$(pgrep -if 'python main.py')" ]; then
  echo "Killing existing server to run a fresh version"
  pkill -9 -if "python main.py"
fi

#Remove generated chapters and e-books (in case new one from other branch in there)
# Or with "true" to prevent failure if files don't exist
echo "Removing Generated Chapters and e-books"
rm -f ./templates/*/*/chapters/* || true
rm -f ./static/pdfs/* || true

# Download latest e-books from Github Action artifacts
echo "Downloading latest e-books from Github Action artifacts"
# Set your GitHub repository and workflow name
REPO_OWNER=HTTPArchive
REPO_NAME=almanac.httparchive.org
WORKFLOW_ID=predeploy.yml

# Get the latest workflow run ID and download its artifact's ZIP file
RUN_ID=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/workflows/${WORKFLOW_ID}/runs" | jq -r '.workflow_runs[0].id')
ARTIFACT_ID=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runs/${RUN_ID}/artifacts" | jq -r '.artifacts[0].id')

if [[ "${ARTIFACT_ID}" != "null" ]]; then
  curl -L -H "Authorization: token ${GITHUB_TOKEN}" -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/artifacts/${ARTIFACT_ID}/zip" -o "${ARTIFACT_ID}.zip"

  # Extract the contents of the ZIP file and clean up
  unzip -q "${ARTIFACT_ID}.zip" -d ./static/pdfs/
  rm "${ARTIFACT_ID}.zip"
fi

echo "Run and test website"
./tools/scripts/run_and_test_website.sh

echo "Please test the site locally"

check_continue "Are you ready to deploy?"

LAST_TAGGED_VERSION=$(git tag -l "v[0-9]*" | sort -V | tail -1)
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

echo "Deploying to GCP"
echo "Y" | gcloud app deploy --project webalmanac --stop-previous-version

if [[ "${ARTIFACT_ID}" != "null" ]]; then
  echo "Deploying ebooks to GCP Storage"
  # shellcheck disable=SC2010
  pdfs=$(cd static/pdfs;ls web_almanac_*)
  for pdf in ${pdfs}
  do
    echo "Uploading $pdf"
    gsutil cp "static/pdfs/${pdf}" "gs://httparchive/almanac/ebooks/${pdf}"
  done
fi

echo "Push production branch"
git push
git status

echo "Checking out main branch"
git checkout main

if [ "$(pgrep -if 'python main.py')" ]; then
  echo "Killing server so backgrounded version isn't left there"
  pkill -9 -if "python main.py"
fi

echo
echo -e "${GREEN}Successfully deployed!${RESET_COLOR}"
echo
echo -e "${AMBER}Please update release on GitHub: https://github.com/HTTPArchive/almanac.httparchive.org/releases${RESET_COLOR}"
echo -e "${AMBER}Using tag ${TAG_VERSION}@production${RESET_COLOR}"
echo
echo "Have a good one!"
echo
exit 0
