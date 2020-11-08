rem ######################################
rem ## Custom Web Almanac script        ##
rem ######################################
rem #
rem # This script stops the website and chapter watcher.
rem #
rem # It is useful as sometimes these are backgrounded so this offers a quick way of stopping them.
rem #
rem 

echo "Kill webserver"
wmic Path win32_process Where "Caption Like '%python.exe%' AND CommandLine Like '%main.py%'" Call Terminate

echo "Kill chapter_watcher"
wmic Path win32_process Where "Caption Like '%node.exe%' AND CommandLine Like '%chapter_watcher%'" Call Terminate
