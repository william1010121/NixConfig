# Home Manager base configuration shared between platforms
{ config, pkgs, lib, isDarwin ? true, ... }:

let
  configDir = if isDarwin then "/private/etc/nix-darwin/config" else "${config.home.homeDirectory}/.config/nix-darwin/config";
in
{
  imports = [
    ./packages.nix
    ./programs/zsh.nix
    ./programs/git.nix
    ./programs/direnv.nix
    ./programs/vim.nix
  ];

  # Home Manager needs information about you and the paths it should manage
  home.username = "guoshengwei";
  home.homeDirectory = if isDarwin then "/Users/guoshengwei" else "/home/guoshengwei";

  # State version - do not change without checking release notes
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Cross-platform dotfiles
  home.file = {
    ".gitconfig".source = ../../config/gitconfig/gitconfig;
    ".gitconfig-csit".source = ../../config/gitconfig/gitconfig-csit;
  };

  # Reset doom config script (platform-aware version created in platform-specific modules)
  home.packages = with pkgs; [
    (writeShellScriptBin "reset-doom-config" ''
      #!/bin/bash
      set -e

      SOURCE="${configDir}/doom"
      TARGET="$HOME/.config/doom"
      TIMESTAMP=$(date +%Y%m%d-%H%M%S)
      BACKUP_DIR="''${TARGET}.''${TIMESTAMP}.bak"

      if [ -e "$TARGET" ]; then
          echo "Backing up existing $TARGET to $BACKUP_DIR"
          mv "$TARGET" "$BACKUP_DIR"
      fi

      echo "Copying $SOURCE to $TARGET"
      cp -R "$SOURCE" "$TARGET"

      echo "Setting write permissions for $TARGET"
      chmod -R u+w "$TARGET"

      echo "Doom configuration reset successfully."
    '')
  ];
}
