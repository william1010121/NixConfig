# Vim configuration
{ config, pkgs, lib, ... }:

{
  home.file.".vimrc".source = ../../../config/vimrc;
}
