#!/bin/bash

######################################
## Custom Web Almanac script        ##
######################################
#
# This script stops the website and chapter watcher.
#
# It is useful as sometimes these are backgrounded so this offers a quick way of stopping them.
#

pkill -9 -if "python main.py"
pkill -9 -if "./tools/generate/chapter_watcher"

exit 0
