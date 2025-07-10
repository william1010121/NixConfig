{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "guoshengwei";
  home.homeDirectory = "/Users/guoshengwei";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain text dotfiles is via 'home.file'.
  home.file = {
    # # Building on the example you found, you can use the following configuration
    # # to symlink '~/.config/nixpkgs/config.nix' to
    # # '~/.dotfiles/nixpkgs/config.nix'.
    # ".config/nixpkgs/config.nix".source = ~/.dotfiles/nixpkgs/config.nix;

    # # You can also set the file content immediately.
    # ".config/nixpkgs/config.nix".text = ''
    #   { allowUnfree = true; }
    # '';
    ".zshrc".source = ../config/zshrc;
    ".vimrc".source = ../config/vimrc;
  };

  programs.zsh = {
    enable = true;
    # autocd = true;
    # dotDir = ".config/zsh";
    # history = {
    #   path = "$HOME/.config/zsh/history";
    #   size = 10000;
    #   share = true;
    # };
    # initExtra = builtins.readFile ./zshrc;
    # shellAliases = {
    #   ll = "ls -l";
    #   update = "sudo nixos-rebuild switch";
    # };
  };
}
