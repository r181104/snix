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
      betterlockscreen
  ];
}
