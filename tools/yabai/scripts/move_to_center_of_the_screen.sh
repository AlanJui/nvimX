#!/bin/bash

# win=$(yabai -m query --windows --window last | jq '.id')
#
# while : ; do
#     yabai -m window $win --swap prev &> /dev/null
#     if [[ $? -eq 1 ]]; then
#         break
#     fi
# done
#

win=$(yabai -m query --windows --window last | jq '.id')

yabai -m window --move abs:100:200
yabai -m window --resize abs:1400:500
