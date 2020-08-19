#!/bin/bash

# exit when any command fails instead of trying to continue on
set -e

echo "Update local production branch"
#git checkout production
git status
#git pull
#git pull origin main

if [ '$(pgrep -f "python main.py")' ]; then
  echo "Killing existing server to run afresh"
  pkill -9 python main.py
fi

echo "Run and test website"
./tools/scripts/run_and_test_website.sh

echo "Generate ebooks"
npm run ebooks

echo "Deploying"
#echo "Y" | gcloud app deploy --project webalmanac --stop-previous-version

echo "Push production branch"
#git push
git status

echo "Done"
exit 0
