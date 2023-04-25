#!/usr/bin/env bash
yabai -m query --windows | jq '.[].app'

