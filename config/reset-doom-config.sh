#!/bin/bash
set -e

SOURCE="/private/etc/nix-darwin/config/doom"
TARGET="$HOME/.config/doom"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="${TARGET}.${TIMESTAMP}.bak"

if [ -e "$TARGET" ]; then
    echo "Backing up existing $TARGET to $BACKUP_DIR"
    mv "$TARGET" "$BACKUP_DIR"
fi

echo "Copying $SOURCE to $TARGET"
cp -R "$SOURCE" "$TARGET"

echo "Setting write permissions for $TARGET"
chmod -R u+w "$TARGET"

echo "Doom configuration reset successfully."
