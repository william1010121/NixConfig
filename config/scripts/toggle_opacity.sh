#!/bin/bash

# Get current window opacity
opacity=$(yabai -m query --windows --window | jq -r '.opacity')

# Toggle between 0.5 (transparent) and 0.0 (reset/opaque)
if (( $(echo "$opacity > 0.9" | bc -l) )); then
  yabai -m window --opacity 0.5
else
  yabai -m window --opacity 0.0
fi
