{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };

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
  ];
}
