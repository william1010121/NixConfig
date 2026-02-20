# Homebrew configuration for macOS
{ config, pkgs, lib, ... }:

{
  homebrew = {
    enable = true;
    onActivation.cleanup = "none";

    taps = [
      "koekeishiya/formulae"
      "d12frosted/emacs-plus"
      "FelixKratz/formulae"
    ];

    brews = [
      "gettext"
      "pcre2"
      "git"
      "yabai"
      "skhd"
      "felixkratz/formulae/borders"
      "brotli"
      "libtiff"
      "little-cms2"
      "emacs-plus@29"
    ];

    casks = [
      "mactex-no-gui"
      "font-meslo-lg-nerd-font"
    ];
  };
}
