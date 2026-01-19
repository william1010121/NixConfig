#!/bin/bash
# Verify that homebrew cleanup is set to "none" in flake.nix

FLAKE_FILE="flake.nix"

if grep -q 'onActivation.cleanup = "none"' "$FLAKE_FILE"; then
  echo "PASS: homebrew.onActivation.cleanup is set to 'none'."
  exit 0
else
  echo "FAIL: homebrew.onActivation.cleanup is NOT set to 'none'."
  exit 1
fi
