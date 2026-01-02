#!/bin/bash
# Check if yabai is running
if ! pgrep -x "yabai" > /dev/null; then
    echo "yabai is not running"
    exit 1
fi

# Try to load scripting additions (expecting failure or password prompt if not configured)
echo "Attempting to load SA..."
sudo -n yabai --load-sa
SA_EXIT=$?
if [ $SA_EXIT -ne 0 ]; then
    echo "Scripting addition load failed (expected in current broken state)"
else
    echo "Scripting addition load succeeded (unexpected)"
fi

# Try to destroy the last space
LAST_SPACE=$(yabai -m query --spaces | jq '.[-1].index')
echo "Attempting to destroy space $LAST_SPACE..."
yabai -m space $LAST_SPACE --destroy
DESTROY_EXIT=$?

# Verify if space still exists
STILL_EXISTS=$(yabai -m query --spaces | jq "map(select(.index == $LAST_SPACE)) | length")

if [ "$STILL_EXISTS" -eq "1" ]; then
    echo "Space destruction failed: Space $LAST_SPACE still exists."
    exit 1
else
    echo "Space destruction succeeded."
    exit 0
fi
