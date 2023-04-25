#!/bin/bash
curWindowId=$(yabai -m query --windows --window | jq -re '.id')
echo "$curWindowId"
