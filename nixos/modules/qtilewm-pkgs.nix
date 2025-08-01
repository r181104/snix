{ config, lib, pkgs, ... }:

with lib;

let
cfg = config.qtilewm-pkgs;
python = pkgs.python311;
pythonPackages = python.pkgs;
in {
  options.qtilewm-pkgs = {
    enable = mkEnableOption "Install Qtile window manager with all dependencies";
    enableX11 = mkOption {
      type = types.bool;
      default = true;
      description = "Enable X11 components";
    };
    enableWayland = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Wayland components";
    };
  };

  config = mkIf cfg.enable {
# Qtile core packages - INCLUDING QTILE ITSELF
    environment.systemPackages = with pkgs; [
# QTILE_CORE_PACKAGES
      pythonPackages.psutil
        pythonPackages.setproctitle
        pythonPackages.dbus-fast
        pythonPackages.iwlib
        pythonPackages.keyring
        pythonPackages.pyxdg
        pythonPackages.cairocffi
        pythonPackages.xcffib
        pythonPackages.xkbcommon

# WM_PACKAGES
        picom
        betterlockscreen
        i3lock-color
        xss-lock
        unclutter
        autorandr

# TERMINAL_PACKAGES
        ghostty
        alacritty

# LAUNCHER_PACKAGES
        rofi-wayland

# NOTIFICATION_PACKAGES
        dunst

# SYSTRAY_PACKAGES
        pavucontrol
        copyq
        polkit_gnome
        volumeicon

# AUDIO_PACKAGES
        jamesdsp
        alsa-utils
        playerctl
        pamixer
        mpv
        vlc

# SCREEN_PACKAGES
        flameshot
        maim
        scrot
        grim
        slurp
        wf-recorder
        obs-studio

# THEME_PACKAGES
        feh
        pythonPackages.pywal
        libsForQt5.qt5ct

# FILE_MANAGER_PACKAGES
        xfce.thunar
        xfce.thunar-volman
        xfce.thunar-archive-plugin
        ranger

# MONITOR_PACKAGES
        lm_sensors
        htop
        btop

# INPUT_PACKAGES
        libinput
        libinput-gestures
        touchegg

# PYTHON_QTILE_PACKAGES
        pythonPackages.libcst
        pythonPackages.pywayland
        pythonPackages.pywlroots
        pythonPackages.requests
        pythonPackages.netifaces
        pythonPackages.pillow
        pythonPackages.python-dateutil

# EDITOR_PACKAGES
        neovim

# NETWORK_PACKAGES
        wpa_supplicant
        dhcpcd
        iwd

# UTILITY_PACKAGES
        redshift
        gammastep
        caffeine-ng
        autokey
        keepassxc
        ] ++ (optionals cfg.enableX11 [
# X11_PACKAGES
            xorg.xorgserver
            xorg.xinit
            xorg.xauth
            xorg.xrandr
            xorg.xset
            xorg.xprop
            xorg.xwininfo
            xorg.xdpyinfo
            xorg.xlsfonts
            xwayland
            xdotool
            wmctrl
            xclip
            xsel
        ]);

# Enable required services
    services = {
      displayManager = {
        defaultSession = "qtile";
      };
      xserver =  {
        enable = true;
        windowManager.qtile = {
          enable = true;  # THIS WAS MISSING
        };
      };
    };

# Configure XDG portals
    xdg.portal = {
      enable = true;
      wlr.enable = cfg.enableWayland;
      extraPortals = with pkgs; [ 
        xdg-desktop-portal-gtk
      ] ++ (optional cfg.enableWayland xdg-desktop-portal-wlr);
    };

# User services for Qtile
    systemd.user.services = {
      dunst = {
        enable = true;
        description = "Dunst notification daemon";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.dunst}/bin/dunst";
          Restart = "always";
        };
      };
    };
  };
}
