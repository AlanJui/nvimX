#!/bin/bash

winID=$(./getCurrentWindowID.sh)

if [[ "$winID" = "$1" ]]; then
    echo "1"
    exit 1
else
    echo "0"
    exit 0
fi
