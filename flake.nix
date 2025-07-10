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
      ];

      # Enable and configure skhd service
      services.skhd = {
        enable = true;
        package = pkgs.skhd;
        skhdConfig = builtins.readFile ./config/skhdrc;
        #skhdConfig = "alt + shift - r  :  chunkc quit";
      };
      services.yabai = {
        enable = true;
        package = pkgs.yabai;
        enableScriptingAddition = true;
        config = {
          focus_follows_mouse = "autofocus";
          window_placement = "second_child";
          window_topmost = "off";
          window_shadow = "on";
          window_opacity = "off";
          active_window_opacity = "1.0";
          normal_window_opacity = "0.90";
          window_border = "off";
          window_border_width = "6";
          active_window_border_color = "0xff775759";
          normal_window_border_color = "0xff555555";
          insert_feedback_color = "0xffd75f5f";
          split_ratio = "0.50";
          auto_balance = "off";
          mouse_modifier = "fn";
          mouse_action1 = "move";
          mouse_action2 = "resize";
          mouse_drop_action = "swap";
          mouse_follows_focus = "on";
          layout = "bsp";
          top_padding = "05";
          bottom_padding = "10";
          left_padding = "10";
          right_padding = "10";
          window_gap = "06";
        };
    extraConfig = ''
      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      osascript -e 'tell application id "tracesOf.Uebersicht" to refresh'


      # yabai -m space --create
      # yabai -m space --create
      # yabai -m space --create
      # yabai -m space --create

      ## focus previous window when window destroyed
      yabai -m signal --add event=window_destroyed action="yabai -m window --focus mouse"
    '';
  };

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
      modules = [ configuration ];
    };
  };
}
