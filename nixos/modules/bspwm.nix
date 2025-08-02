{ config, pkgs, ... }:
{
  services.xserver.windowManager.bspwm.enable = true;
  environment.systemPackages = with pkgs; [
    bspwm
      sxhkd
      feh
      polybar
      rofi-wayland
      betterlockscreen
  ];
}
