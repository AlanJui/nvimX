#!/bin/dash
curWindowId="$(yabai -m query --windows --window | jq ".id")"

$(yabai -m window --display next || yabai -m window --display first)
$(yabai -m window --focus "$curWindowId")

