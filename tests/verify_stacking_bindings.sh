#!/bin/bash
# Verify that yabai stacking key bindings are present in skhdrc
# and that old resize bindings are correctly reorganized.

SKHDRC="config/skhdrc"

# Function to check for a line in skhdrc
check_binding() {
  local binding="$1"
  local description="$2"
  if grep -qF "$binding" "$SKHDRC"; then
    echo "PASS: $description found: '$binding'"
  else
    echo "FAIL: $description NOT found: '$binding'"
    return 1
  fi
}

# Function to check absence of a line
check_absence() {
  local binding="$1"
  local description="$2"
  if grep -qF "$binding" "$SKHDRC"; then
    echo "FAIL: $description STILL found: '$binding'"
    return 1
  else
    echo "PASS: $description not present as expected: '$binding'"
  fi
}

EXIT_CODE=0

echo "--- Verifying Stacking Bindings ---"
check_binding "ctrl + alt - j : /opt/homebrew/bin/yabai -m window --focus stack.next" "Stack Navigation (Next)" || EXIT_CODE=1
check_binding "ctrl + alt - k : /opt/homebrew/bin/yabai -m window --focus stack.prev" "Stack Navigation (Prev)" || EXIT_CODE=1
check_binding "ctrl + alt - s : /opt/homebrew/bin/yabai -m window --insert stack" "Stack Insertion" || EXIT_CODE=1

echo ""
echo "--- Verifying Reorganized Resize Bindings ---"
check_binding "ctrl + alt + cmd - h : /opt/homebrew/bin/yabai -m window --resize left:-40:0" "Increase Resize (Left)" || EXIT_CODE=1
check_binding "ctrl + alt + cmd - j : /opt/homebrew/bin/yabai -m window --resize bottom:0:40" "Increase Resize (Bottom)" || EXIT_CODE=1
check_binding "ctrl + alt + cmd - k : /opt/homebrew/bin/yabai -m window --resize top:0:-40" "Increase Resize (Top)" || EXIT_CODE=1
check_binding "ctrl + alt + cmd - l : /opt/homebrew/bin/yabai -m window --resize right:40:0" "Increase Resize (Right)" || EXIT_CODE=1

echo ""
echo "--- Verifying Absence of Old Bindings ---"
# Old Increase Bindings (should no longer use ctrl + alt)
check_absence "ctrl + alt - h : /opt/homebrew/bin/yabai -m window --resize left:-40:0" "Old Increase Resize (Left)" || EXIT_CODE=1
check_absence "ctrl + alt - j : /opt/homebrew/bin/yabai -m window --resize bottom:0:40" "Old Increase Resize (Bottom)" || EXIT_CODE=1
check_absence "ctrl + alt - k : /opt/homebrew/bin/yabai -m window --resize top:0:-40" "Old Increase Resize (Top)" || EXIT_CODE=1
check_absence "ctrl + alt - l : /opt/homebrew/bin/yabai -m window --resize right:40:0" "Old Increase Resize (Right)" || EXIT_CODE=1

# Old Decrease Bindings (should be removed)
check_absence "ctrl + alt + cmd - h : /opt/homebrew/bin/yabai -m window --resize left:40:0" "Old Decrease Resize (Left)" || EXIT_CODE=1
check_absence "ctrl + alt + cmd - j : /opt/homebrew/bin/yabai -m window --resize bottom:0:-40" "Old Decrease Resize (Bottom)" || EXIT_CODE=1
check_absence "ctrl + alt + cmd - k : /opt/homebrew/bin/yabai -m window --resize top:0:40" "Old Decrease Resize (Top)" || EXIT_CODE=1
check_absence "ctrl + alt + cmd - l : /opt/homebrew/bin/yabai -m window --resize right:-40:0" "Old Decrease Resize (Right)" || EXIT_CODE=1

exit $EXIT_CODE
