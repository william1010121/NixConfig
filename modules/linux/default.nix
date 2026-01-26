# Linux Home Manager configuration
{ config, pkgs, lib, ... }:

{
  imports = [
    ../common/home-base.nix
    ./packages.nix
  ];

  # Pass isDarwin = false to common modules
  _module.args.isDarwin = false;

  # Enable generic Linux target
  targets.genericLinux.enable = true;

  # Enable XDG directories
  xdg.enable = true;

  # Linux-specific packages
  home.packages = with pkgs; [
    # zsh-autosuggestions for Linux (managed by Homebrew on macOS)
    zsh-autosuggestions
  ];
}
