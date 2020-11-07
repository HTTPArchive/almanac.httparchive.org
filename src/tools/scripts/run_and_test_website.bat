rem ######################################
rem ## Custom Web Almanac script        ##
rem ######################################
rem #
rem # This script installs all the required dependencies needed to run the
rem # Web Almanac website providing you have python and node installed.
rem #
rem # It 's a simplified version of run_and_test_website.sh for windows users
rem # It depends on Python 3.8, pip and nodejs 12 being installed already
rem #


echo "Installing and testing python environment"
python -m pip install --upgrade pip
pip install -r requirements.txt
pytest

echo "Installing node modules"
call npm install

echo "Building website"
call npm run generate

echo "Starting website"
start python main.py background
rem # Sleep for a couple of seconds to make sure server is up
timeout /t 2 /nobreak

echo "Testing website"
call npm run test

echo "Website started successfully"
