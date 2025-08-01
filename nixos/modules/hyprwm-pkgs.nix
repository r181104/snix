{ config, lib, pkgs, ... }:

let
# Combine all package lists
allPackages = with pkgs; [
# Hyprland packages
  hyprland
  pyprland
  hypridle
  hyprlock
  hyprpicker

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
  xwaylandvideobridge

# System utilities
  bluez
  brightnessctl
  pavucontrol

# Terminal/Editor
  kitty

# GUI applications
  gnome.nautilus
  rofi-wayland
  nwg-look

# Themes
  papirus-icon-theme
  nordzy-cursor-theme
  pywal
  ];
  in {
    options.hyprland-packages.enable = lib.mkEnableOption "Hyprland custom package set";

    config = lib.mkIf config.hyprland-packages.enable {
# Enable Hyprland and Wayland support
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

# Desktop portal configuration
      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
            xdg-desktop-portal-gtk
        ];
      };

# System packages
      environment.systemPackages = allPackages;

# Environment variables for Wayland
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";  # Enable Wayland for Chromium-based apps
          QT_QPA_PLATFORM = "wayland";
        SDL_VIDEODRIVER = "wayland";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "Hyprland";
      };
    };
  }
