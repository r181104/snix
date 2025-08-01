{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

# Boot Configuration
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
# Enable early KMS for faster boot
    initrd.kernelModules = [ "nvidia" ]; # Replace with your GPU driver if different
  };

# Network Configuration
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
# Enable firewall (recommended for security)
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

# Internationalization
  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

# X11 Desktop Environment
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.budgie.enable = true;
# Configure keymap
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.libinput.enable = true;

# Sound Configuration
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

# User Configuration
  users.users.hack = {
    isNormalUser = true;
    description = "hack";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "lp" ];
    shell = pkgs.zsh; # Set default shell to Zsh
  };

# System Packages
  environment.systemPackages = with pkgs; [
# Core utilities
    vim neovim tmux zsh bash fzf zoxide ripgrep bat btop htop tree
      wget curl rsync unzip zip p7zip man man-pages

# Development tools
      git rustup go nodejs python3Full pipx gnumake cmake
      autoconf automake pkg-config stow lua-language-server

# GUI applications
      firefox libreoffice vlc mpv qbittorrent

# Hardware utilities
      blueman pavucontrol brightnessctl usbutils pciutils lshw
      upower inxi

# Media processing
      imagemagick ffmpeg-full yt-dlp

# Security tools
      sbctl mokutil openssl gnupg keepassxc

# Fonts
      font-awesome powerline-fonts

# Terminal tools
      lazygit

# X11 utilities
      xclip xdg-utils xdg-desktop-portal-gtk

# Bluetooth
      bluez bluez-tools

# Fixed dependencies
      libgccjit # Needed for some compiled packages
      gsettings-desktop-schemas # Required for Budgie
      gnome.adwaita-icon-theme # Fix for missing icons
      ];

# System Services
  services = {
    printing.enable = true;   # CUPS
      blueman.enable = true;    # Bluetooth manager
      openssh.enable = false;   # Disable SSH server by default
  };

# System Configuration
  programs = {
    firefox.enable = true;
    zsh.enable = true;        # Enable Zsh system-wide
  };

# Nix Settings
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

# Security
  security = {
    sudo.wheelNeedsPassword = true;  # Require password for sudo
      polkit.enable = true;
  };

# Hardware
  hardware = {
    bluetooth.enable = true;  # Enable Bluetooth support
      graphics.enable = true;
  };

  services.pulseaudio.enable = false; # Disable in favor of PipeWire

# Allow unfree packages
    nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
