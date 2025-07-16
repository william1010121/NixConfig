{ config, pkgs, ... }:

let
  toggle-reminders-script = pkgs.writeShellScript "toggle-reminders.sh" ''
    #!${pkgs.bash}/bin/bash
    export PATH=${pkgs.lib.makeBinPath [ pkgs.yabai pkgs.jq pkgs.coreutils ]}:$PATH

    APP="Reminders"

    # Check if Reminders is the frontmost application
    IS_FRONTMOST=$(osascript -e 'tell application "System Events" to get name of first process whose frontmost is true' | tr -d '"')

    if [ "$IS_FRONTMOST" = "$APP" ]; then
        # If it is frontmost, hide it
        osascript -e "tell application \"System Events\" to set visible of process \"$APP\" to false"
    else
        # If it's not frontmost, bring it to the front
        open -a "$APP"
        sleep 0.2 # Give it a moment to come to the front

        # Get the window ID for the Reminders window
        WINDOW_ID=$(yabai -m query --windows | jq --arg app "$APP" '.[] | select(.app == $app) | .id' | head -n 1)

        if [ -n "$WINDOW_ID" ]; then
            # Focus the window first
            yabai -m window --focus "$WINDOW_ID"
            
            
            
            # Ensure the window is floating
            IS_FLOATING=$(yabai -m query --windows --window "$WINDOW_ID" | jq -r '.["is-floating"]')
            if [ "$IS_FLOATING" = "false" ]; then
                yabai -m window "$WINDOW_ID" --toggle float
            fi

            
        fi
    fi
  '';
in
{
  # yabai & skhd
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse = "off";
      mouse_follows_focus = "on";
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
      yabai -m config external_bar all:28:0 # If not using a status bar like sketchybar/ubersicht


      # yabai -m space --create
      # yabai -m space --create
      # yabai -m space --create
      # yabai -m space --create

      ## focus previous window when window destroyed
      yabai -m signal --add event=window_destroyed action="yabai -m window --focus mouse"

      # Rule for Reminders app
      yabai -m rule --add app="^Reminders$" floating=on
    '';
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = (builtins.readFile ../config/skhdrc) + ''

      # Toggle Reminders at center of screen
      cmd + alt + shift - r : ${toggle-reminders-script}
    '';
  };
}
