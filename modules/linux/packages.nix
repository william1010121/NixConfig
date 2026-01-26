# Linux-specific packages (X11, GNOME, etc.)
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # X11 packages
    xorg.libX11
    xorg.libXau
    xorg.libXdmcp
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.xorgproto

    # GNOME/GTK dependencies
    gdk-pixbuf
    dbus
    at-spi2-core
    adwaita-icon-theme
    desktop-file-utils
    shared-mime-info
  ];
}
