#!/bin/bash

# exit when any command fails instead of trying to continue on
set -e

# Check branch is clean first
if [ -n "$(git status --porcelain)" ]; then 
  read -r -n 1 -p "Your branch is not clean. Do you still want to deploy? [y/N]: " DEPLOY
  if [ "$DEPLOY" != "Y" ] && [ "$DEPLOY" != "y" ]; then
      echo
      echo "Cancelling deploy"
      exit 0
  fi
fi
echo

read -r -n 1 -p "Please confirm you've updated the eBooks via GitHub Actions. [y/N]: " DEPLOY
if [ "$DEPLOY" != "Y" ] && [ "$DEPLOY" != "y" ]; then
    echo
    echo "Cancelling deploy"
    exit 0
fi
echo

echo "Update local production branch"
git checkout production
git status
git pull
git pull origin main

if [ "$(pgrep -f 'python main.py')" ]; then
  echo "Killing existing server to run afresh"
  pkill -9 python main.py
fi

echo "Run and test website"
./tools/scripts/run_and_test_website.sh

echo "Please test the site locally"

read -r -n 1 -p "Are you ready to deploy? [y/N]: " DEPLOY
if [ "$DEPLOY" != "Y" ] && [ "$DEPLOY" != "y" ]; then
    echo
    echo "Cancelling deploy"
    exit 0
fi
echo

LAST_TAGGED_VERSION=$(git tag -l "v*" | tail)
echo "Last tagged version: $LAST_TAGGED_VERSION"
if [[ "$LAST_TAGGED_VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  semver=( "${LAST_TAGGED_VERSION//./ }" )
  major="${semver[0]}"
  minor="${semver[1]}"
  patch="${semver[2]}"
  next_patch=$((patch + 1))
  NEXT_VERSION="$major.$minor.$next_patch"
else
  echo "Warning - last tagged version is not of the format vX.X.X!"
fi

TAG_VERSION=""
while [[ ! "$TAG_VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]
do
  echo "Please update major tag version when changing default year"
  echo "Please update minor tag version when adding new languages or other large changes"
  read -r -p "Please select tag version of the format vX.X.X. [$NEXT_VERSION]: " TAG_VERSION
done
echo "Tagging as $TAG_VERSION"

LONG_DATE=$(date -u +%Y-%m-%d\ %H:%M:%S)
git tag -a "$TAG_VERSION" -m "Version $TAG_VERSION $LONG_DATE"
echo "Version $TAG_VERSION $LONG_DATE"

if [[ -f deploy.zip ]]; then
  echo "Removing old deploy.zip"
  rm deploy.zip
fi

echo "Zipping into deploy.zip"
zip -q -r deploy . --exclude @.gcloudignore

echo "Deploying"
echo Y | gcloud app deploy --project webalmanac --stop-previous-version

echo "Push production branch"
git push
git status

echo "Please update release on GitHub using tag $TAG_VERSION@production"
echo "Please upload deploy.zip as the release artifact"
exit 0
