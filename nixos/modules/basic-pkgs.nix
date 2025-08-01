{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
# SYSTEM_PACKAGES
    networkmanager networkmanagerapplet
      blueman bluez
      brightnessctl pavucontrol
      acl alsa-utils alsa-plugins
      pipewire
      pciutils usbutils hwdata lshw
      upower accountsservice polkit dbus udisks gvfs

# TERMINAL_PACKAGES
      neovim vim tmux zsh bash
      fzf zoxide ripgrep bat
      btop htop tree less gnugrep gnused gawk
      which curl wget rsync unzip zip gnutar gzip p7zip
      lazygit man-db texinfo

# GUI_PACKAGES
      libreoffice vlc mpv

# DEV_PACKAGES
      git gh rustup go nodejs
      python3 python3Packages.pip python3Packages.setuptools python3Packages.wheel python3Packages.virtualenv
      gcc gnumake cmake autoconf automake pkg-config stow

# THEME_PACKAGES
      font-awesome powerline-fonts nitch lxappearance

# SECURITY_PACKAGES
      sbctl mokutil openssl openssh gnupg pass keepassxc

# UTILITY_PACKAGES
      bc xclip wl-clipboard xdg-utils xdg-user-dirs xdg-desktop-portal
      mesa-demos vulkan-tools inxi imagemagick ffmpeg yt-dlp qbittorrent
      ];

# XDG portals
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

# User environment configuration
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

# Kernel modules
  boot.kernelModules = [ "tcp_bbr" "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
}
