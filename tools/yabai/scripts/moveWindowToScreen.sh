#!/usr/bin/env bash

# get current window id
curWindowId="$(yabai -m query --windows --window | jq -re '.id')"

# move current window to display by number / recent / prev / next
$(yabai -m window --display "$1")

# focus window by window id
$(yabai -m window --focus "$curWindowId")

