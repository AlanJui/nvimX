#!/bin/bash

# currWinID="$(./getCurrentWindowID.sh)"
currWinID=$1
result="$(./isWinIdMatched.sh $currWinID)"

# Debug:
echo "\$currWinID = $currWinID"
echo "\$result = $result"

if [[ "$result" = 1 ]]; then
    echo "matched"
else
    echo "not matched"
fi

