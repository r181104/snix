{
  config,
  pkgs,
  ...
}: {
  services.xserver.windowManager.bspwm.enable = true;
  environment.systemPackages = with pkgs; [
    bspwm
    sxhkd
    feh
    picom
    dunst
    polybar
    pywal
    bemenu
    i3lock-color
    papirus-icon-theme
    libinput-gestures
    xfce.thunar
    xorg.xorgserver
  ];
}
