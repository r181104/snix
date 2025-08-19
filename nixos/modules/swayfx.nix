{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    swayfx
    swaybg
    swaylock-effects
    swayidle
    wofi
    imv
    mpd
    mpc
    kpcli
    cmatrix
    kanshi
    wdisplays
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}
