{ config, lib, pkgs, ... }:
{
# Setup for Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
# Hyprland packages
    hyprland
      hyprland-qtutils
      pyprland
      hypridle
      hyprlock
      hyprpicker
      wayland-utils
      swaynotificationcenter

# Desktop portals
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal

# Wayland utilities
      jamesdsp
      grimblast
      waybar
      swww
      wlogout
      wl-clipboard
      wlroots

# System utilities
      bluez
      brightnessctl
      pavucontrol

# Terminal/Editor
      kitty

# GUI applications
      rofi-wayland
      nwg-look

# Themes
      papirus-icon-theme
      nordzy-cursor-theme
      pywal
      ];

# Desktop portal configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
    ];
  };

# Environment variables for Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # Enable Wayland for Chromium-based apps
      QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
}
