#!/bin/bash

# Define expected Nix path pattern
NIX_PATH_PATTERN="profiles/per-user"

# Check if openfortivpn exists
if ! command -v openfortivpn &> /dev/null; then
    echo "FAIL: openfortivpn command not found"
    exit 1
fi

# Check where openfortivpn is pointing
CURRENT_PATH=$(command -v openfortivpn)
echo "Found openfortivpn at: $CURRENT_PATH"

if [[ "$CURRENT_PATH" != *"$NIX_PATH_PATTERN"* ]]; then
    echo "FAIL: openfortivpn is not pointing to a Nix store path. Expected path containing: $NIX_PATH_PATTERN"
    echo "It might still be pointing to Homebrew or another location."
    exit 1
fi

# Check if openfortivpn runs (version check)
if ! openfortivpn --version &> /dev/null; then
    echo "FAIL: openfortivpn --version failed to execute."
    exit 1
fi

echo "SUCCESS: openfortivpn is installed via Nix and executable."
exit 0
