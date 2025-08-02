{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bspwm
      sxhkd
      feh
  ];
}
