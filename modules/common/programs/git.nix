# Git configuration
{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "william";
        email = "william950615@gmail.com";
      };
      core = {
        compression = 0;
      };
      http = {
        postBuffer = "1M";
        maxRequestBuffer = "100M";
      };
      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
      safe = {
        directory = "/Users/guoshengwei/Desktop/python/bot";
      };
    };

    # Include CSIT config when in CSIT directory
    includes = [
      {
        condition = "gitdir:~/CSIT/";
        path = "~/.gitconfig-csit";
      }
    ];
  };
}
