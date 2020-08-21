#!/bin/bash

# exit when any command fails instead of trying to continue on
set -e

# Check branch is clean first
if [ ! -z "$(git status --porcelain)" ]; then 
  echo "Your branch includes changes that must be commited or remove. Exiting"
  exit 1
fi

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

echo "Generate ebooks"
npm run ebooks

echo "Please test the site locally"

read -r -n 1 -p "Are you ready to deploy?: [Y/N]" DEPLOY
if [ "$DEPLOY" != "Y" ] && [ "$DEPLOY" != "y" ]; then
    echo
    echo "Cancelling deploy"
    exit 0
fi

echo "Deploying"
gcloud app deploy --project webalmanac --stop-previous-version

read -r -n 1 -p "Are you happy to push changes to production?: [Y/N]" DEPLOY
if [ "$DEPLOY" != "Y" ] && [ "$DEPLOY" != "y" ]; then
    echo
    echo "Exiting"
    exit 0
fi

echo "Push production branch"
git push
git status

echo "Done"
exit 0
