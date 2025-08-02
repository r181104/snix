{ config, pkgs, ... }:
{
  services.xserver.windowManager.bspwm.enable = true;
  environment.systemPackages = with pkgs; [
    bspwm
      sxhkd
      feh
      picom
      polybar
      rofi-wayland
      i3lock-color
      papirus-icon-theme
      xfce.thunar
  ];
}
