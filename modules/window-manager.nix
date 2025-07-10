{ config, pkgs, ... }:

{
  # yabai & skhd
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

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = builtins.readFile ../config/skhdrc;
  };
}