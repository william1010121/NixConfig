{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile.
      environment.systemPackages = [
        pkgs.vim
        pkgs.neovim
        # skhd package is still needed for the service to use.
        pkgs.skhd
        pkgs.yabai
        pkgs.lazygit
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility.
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      system.primaryUser = "guoshengwei";
    };
  in
  {
    darwinConfigurations."macos" = nix-darwin.lib.darwinSystem {
      modules = [ ./modules/window-manager.nix configuration ];
    };
  };
}
