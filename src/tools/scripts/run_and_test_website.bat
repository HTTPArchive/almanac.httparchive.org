rem ######################################
rem ## Custom Web Almanac script        ##
rem ######################################
rem #
rem # This script installs all the required dependencies needed to run the
rem # Web Almanac website providing you have python and node installed.
rem #
rem # It 's a simplified version of run_and_test_website.sh for windows users
rem # It depends on Python 3.12, pip and nodejs 20 being installed already
rem #

echo "Kill any existing instances of the webserver"
wmic Path win32_process Where "Caption Like '%%python.exe%%' AND CommandLine Like '%%main.py%%'" Call Terminate

echo "Kill any existing instances of the file watcher"
wmic Path win32_process Where "Caption Like '%%node.exe%%' AND CommandLine Like '%%chapter_watcher%%'" Call Terminate

echo "Installing and testing python environment"
python -m pip install --upgrade pip
pip install -r requirements.txt

echo "Installing node modules"
call npm install

echo "Building website"
call npm run generate

echo "Starting website"
start python main.py
rem # Sleep for 5 seconds to make sure server is up
timeout /t 5 /nobreak
rem # Use sleep as well in case running in GitBash where above command fails
sleep 5

echo "Running pytest"
npm run pytest

echo "Testing website"
call npm run test

echo "Monitoring templates for changes"
call npm run watch

echo "Website started successfully"
