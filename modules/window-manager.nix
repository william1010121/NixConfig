{ config, pkgs, lib, ... }:

{
  # yabai & skhd
  # services.yabai = {
  #   enable = true;
  #   package = pkgs.yabai;
  #   enableScriptingAddition = true;
  #   config = {
  #     focus_follows_mouse = "off";
  #     mouse_follows_focus = "on";
  #     window_placement = "second_child";
  #     # window_topmost = "off"; # Deprecated/Removed in newer versions
  #     # window_shadow = "on";   # Deprecated/Removed
  #     # window_opacity = "off"; # Deprecated/Removed
      
  #     split_ratio = "0.50";
  #     auto_balance = "off";
  #     mouse_modifier = "fn";
  #     mouse_action1 = "move";
  #     mouse_action2 = "resize";
  #     mouse_drop_action = "swap";
  #     layout = "bsp";
  #     top_padding = 5;
  #     bottom_padding = 10;
  #     left_padding = 10;
  #     right_padding = 10;
  #     window_gap = 6;
  #   };
  #   extraConfig = ''
  #     # Load scripting addition manually if service doesn't do it automatically, 
  #     # but enableScriptingAddition usually handles the startup. 
  #     # However, we add the signal for dock restarts.
  #     yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
  #     
  #     # Refresh Uebersicht if running
  #     osascript -e 'tell application id "tracesOf.Uebersicht" to refresh'
  #     
  #     # External bar configuration
  #     yabai -m config external_bar all:28:0

  #     ## focus previous window when window destroyed
  #     yabai -m signal --add event=window_destroyed action="yabai -m window --focus mouse"
  #   '';
  # };

  # services.skhd = {
  #   enable = true;
  #   package = pkgs.skhd;
  #   skhdConfig = builtins.readFile ../config/skhdrc;
  # };

  # Allow yabai to load scripting additions without password
  # We only include the Homebrew path since we are reverting to Homebrew management
  # Note: On macOS 16, scripting additions may fail to load or function correctly (e.g., space destruction)
  # even with this configuration.
  security.sudo.extraConfig = ''
    %admin ALL=(ALL) NOPASSWD: /opt/homebrew/bin/yabai --load-sa
  '';
}
