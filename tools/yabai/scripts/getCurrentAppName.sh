#!/bin/dash
# $1 
curWindowId="$(yabai -m query --windows --window | jq ".id")"

$(yabai -m window --display next || yabai -m window --display first)
$(yabai -m window --focus "$curWindowId")

if [[ "$(yabai -m query --windows --window) | jq '.app'" == "$1" ]]; then
    echo "相等"
    echo "id = ${curWindowId}"
else
    echo "不等"
fi
