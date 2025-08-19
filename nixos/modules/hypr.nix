{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pyprland
    hypridle
    hyprland-qt-support
    hyprland-qtutils
    hyprlock
    hyprpicker
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    waybar
    swww
    wlogout
    wl-clipboard
    wlroots
    libsForQt5.xwaylandvideobridge
    xwayland-run
    nautilus
    nwg-look
  ];
  programs.hyprland.enable = true;
  programs.xwayland.enable = true;
}
