# Window manager configuration for macOS (yabai & skhd)
{ config, pkgs, lib, ... }:

{
  # yabai & skhd are managed by Homebrew
  # This module handles the sudo configuration for yabai scripting additions

  # Allow yabai to load scripting additions without password
  # Note: On macOS 16, scripting additions may fail to load or function correctly
  # even with this configuration.
  security.sudo.extraConfig = ''
    %admin ALL=(ALL) NOPASSWD: /opt/homebrew/bin/yabai --load-sa
  '';
}
