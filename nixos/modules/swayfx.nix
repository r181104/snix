{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    swayfx
    imv
    mpd
    mpc
    kpcli
    cmatrix
  ];
}
