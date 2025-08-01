{ config, lib, pkgs, ... }:

with lib;

let
cfg = config.basic-pkgs;
in {
  options.basic-pkgs = {
    enable = mkEnableOption "Install essential base packages";
    enableServices = mkOption {
      type = types.bool;
      default = true;
      description = "Enable related system services";
    };
  };

  config = mkIf cfg.enable {
# System Packages
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

# Hardware configuration
    hardware.enableRedistributableFirmware = mkDefault true;
    hardware.bluetooth.enable = mkDefault true;

# Service configurations
    services = mkIf cfg.enableServices {
# Bluetooth
      blueman.enable = true;

# Audio
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
      };

# System services
      upower.enable = true;
      accounts-daemon.enable = true;
      udisks2.enable = true;
      dbus.enable = true;
      openssh.enable = true;
      gnome.gnome-keyring.enable = true;

# Printing
      printing.enable = mkDefault true;
    };

# Security services
    security = {
      polkit.enable = true;
      pam.services.login.enableGnomeKeyring = true;
    };

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
      zsh.enable = true;
    };

# Kernel modules
    boot.kernelModules = [ "tcp_bbr" "v4l2loopback" ];
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  };
}
