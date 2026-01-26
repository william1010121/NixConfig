# macOS-specific Home Manager configuration
{ config, pkgs, lib, ... }:

{
  imports = [
    ../common/home-base.nix
  ];

  # Pass isDarwin to common modules
  _module.args.isDarwin = true;

  # macOS-specific dotfiles
  home.file = {
    ".yabairc".source = ../../config/yabairc;
    ".skhdrc".source = ../../config/skhdrc;
  };

  # macOS-specific packages
  home.packages = with pkgs; [
    flutter
  ];
}
