{
  description = "Cross-platform Nix configuration for macOS and Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    # User configuration
    userConfig = {
      username = "guoshengwei";
      email = "william950615@gmail.com";
    };

    # Helper function to create systems for multiple architectures
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
      "aarch64-linux"
    ];
  in
  {
    # ==========================================
    # macOS Configuration (nix-darwin)
    # ==========================================
    darwinConfigurations."william-2" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        # System modules
        ./modules/darwin/default.nix
        ./modules/darwin/homebrew.nix
        ./modules/darwin/window-manager.nix

        # Host-specific configuration
        ./hosts/william-2/default.nix

        # Home Manager integration
        home-manager.darwinModules.home-manager
        {
          home-manager.backupFileExtension = "backup";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { isDarwin = true; };
          users.users.${userConfig.username}.home = "/Users/${userConfig.username}";
          home-manager.users.${userConfig.username} = import ./modules/darwin/home.nix;
        }
      ];
    };

    # ==========================================
    # Linux Configuration (Home Manager standalone)
    # ==========================================

    # Linux x86_64
    homeConfigurations."${userConfig.username}@linux" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { isDarwin = false; };
      modules = [
        ./modules/linux/default.nix
        ./hosts/linux/default.nix
        ./users/${userConfig.username}/default.nix
      ];
    };

    # Linux aarch64 (ARM)
    homeConfigurations."${userConfig.username}@linux-arm" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.aarch64-linux;
      extraSpecialArgs = { isDarwin = false; };
      modules = [
        ./modules/linux/default.nix
        ./hosts/linux/default.nix
        ./users/${userConfig.username}/default.nix
      ];
    };

    # ==========================================
    # Development Shells
    # ==========================================
    devShells = forAllSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixpkgs-fmt
            nil  # Nix LSP
          ];
          shellHook = ''
            echo "Nix development shell"
            echo "Available commands:"
            echo "  darwin-rebuild build --flake .#william-2   # Build macOS config"
            echo "  darwin-rebuild switch --flake .#william-2  # Apply macOS config"
            echo "  home-manager switch --flake .#guoshengwei@linux  # Apply Linux config"
          '';
        };
      }
    );
  };
}
