{ config, lib, pkgs, ... }:

with lib;

let
cfg = config.qtilewm-pkgs;
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
# Qtile core packages
    environment.systemPackages = with pkgs; [
# QTILE_CORE_PACKAGES
      python311Packages.psutil
        python311Packages.setproctitle
        python311Packages.dbus-fast
        python311Packages.iwlib
        python311Packages.keyring
        python311Packages.pyxdg
        python311Packages.cairocffi
        python311Packages.xcffib
        python311Packages.xkbcommon

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
        networkmanagerapplet
        blueman
        networkmanagerapplet
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
        python311Packages.pywal
        libsForQt5.qt5ct

# FILE_MANAGER_PACKAGES
        xfce.thunar
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
        python311Packages.libcst
        python311Packages.pywayland
        python311Packages.pywlroots
        python311Packages.requests
        python311Packages.netifaces
        python311Packages.pillow
        python311Packages.python-dateutil

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
        ];

# Enable required services
    services = {
      xserver = {
        enable = true;
        windowManager.qtile = {
          extraPackages = python311Packages: with python311Packages; [
            cairocffi
              dbus-fast
              iwlib
              keyring
              psutil
              pyxdg
              setproctitle
              xcffib
              xkbcommon
          ];
        };
      };
    };

    services.displayManager = {
      defaultSession = "budgie-desktop";
    };
# Environment variables
    environment.variables = {
      QT_QPA_PLATFORM = "xcb";
      SDL_VIDEODRIVER = "x11";
      XDG_CURRENT_DESKTOP = "qtile";
    };

# Configure XDG portals
    xdg.portal = {
      enable = true;
      wlr.enable = cfg.enableWayland;
      extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
      ];
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
