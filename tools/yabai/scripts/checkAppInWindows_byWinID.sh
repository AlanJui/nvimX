#!/bin/bash

# winID=$(source getCurrentWindowID.sh)
winID=$(./getCurrentWindowID.sh)
appName=$(yabai -m query --windows --window | jq -re '.app')

# For debug info
# echo "\$winID = $winID"
# echo "\$appName = $appName"
# echo "\$1 = $1"

if [ "$winID" = "$1" ]; then
    echo "${appName}"
else
    echo null
fi
