#!/bin/bash
# Verify Yabai Stacking Bindings and Visual Enhancements

SKHDRC="config/skhdrc"
YABAIRC="config/yabairc"
HOMEBREW_CONFIG="modules/darwin/homebrew.nix"

check_file_content() {
  local file="$1"
  local pattern="$2"
  local description="$3"
  if grep -qF "$pattern" "$file"; then
    echo "PASS: $description found in $file"
  else
    echo "FAIL: $description NOT found in $file: '$pattern'"
    return 1
  fi
}

EXIT_CODE=0

echo "--- Verifying Stacking & Visual Config ---"
check_file_content "$SKHDRC" "ctrl + alt - j : /opt/homebrew/bin/yabai -m window --focus stack.next" "Stack Next Binding" || EXIT_CODE=1
check_file_content "$SKHDRC" "alt + cmd - p : /private/etc/nix-darwin/config/scripts/toggle_opacity.sh" "Toggle Opacity Script Binding" || EXIT_CODE=1
check_file_content "$SKHDRC" "alt + cmd - a : /opt/homebrew/bin/yabai -m space --toggle padding" "Toggle Padding Binding" || EXIT_CODE=1
check_file_content "$SKHDRC" "ctrl + alt + cmd - s : /opt/homebrew/bin/yabai -m space --layout stack" "Stack Layout Binding" || EXIT_CODE=1
check_file_content "$YABAIRC" "yabai -m config window_gap 10" "Window Gap 10" || EXIT_CODE=1
check_file_content "$YABAIRC" "active_color=0xff387ADF" "Beautiful Blue Border Color" || EXIT_CODE=1
check_file_content "$HOMEBREW_CONFIG" "felixkratz/formulae/borders" "Borders Utility in Homebrew" || EXIT_CODE=1

exit $EXIT_CODE
