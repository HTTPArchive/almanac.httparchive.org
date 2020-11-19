#!/bin/bash

######################################
## Custom Web Almanac script        ##
######################################
#
# This script stops the website and chapter watcher.
#
# It is useful as sometimes these are backgrounded so this offers a quick way of stopping them.
#

pkill -9 -f "python main.py"
pkill -9 -f "./tools/generate/chapter_watcher"

exit 0
