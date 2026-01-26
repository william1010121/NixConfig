# Darwin (macOS) system configuration
{ pkgs, config, lib, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    neovim
    lazygit
  ];

  # Necessary for using flakes on this system
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility
  system.stateVersion = 6;

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Primary user configuration
  system.primaryUser = "guoshengwei";
}
