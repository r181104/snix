{ config, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
    ];

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-hak"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
    networking.networkmanager.enable = true;

# Set your time zone.
  time.timeZone = "Asia/Kolkata";

# Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
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

# Enable the X11 windowing system.
  services.xserver.enable = true;

# Enable the Budgie Desktop environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.budgie.enable = true;

# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

# Enable CUPS to print documents.
  services.printing.enable = true;

# Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;

# use the example session manager (no others are packaged yet so this is enabled by default,
# no need to redefine it in your config for now)
#media-session.enable = true;
  };

# Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hack = {
    isNormalUser = true;
    description = "hack";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

# Install firefox.
  programs.firefox.enable = true;

# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# $ nix search wget
  environment.systemPackages = with pkgs; [
# Base packages
    blueman
      bluez
      bluez-alsa
      brightnessctl
      pavucontrol
      acl
      alsa-utils
      alsa-plugins
      alsa-lib
      pipewire
# pipewire-pulse
# pipewire-alsa
# pipewire-jack
      pciutils
      libpulseaudio
      usbutils
      hwdata
      lshw
      upower
      accountsservice
      polkit
      dbus
      udisks
      gvfs
# Terminal Packages
      neovim
      vim
      tmux
      zsh
      bash
      fzf
      zoxide
      ripgrep
      bat
      btop
      htop
      tree
      less
      gnugrep
      gnused
      gawk
      which
      wget
      curl
      rsync
      unzip
      zip
      gnutar
      gzip
      p7zip
      lazygit
      man
      texinfo
      black
      stylua
      prettier
      astyle
      libgcc
      shfmt
      lua-language-server
# Gui Packages
      libreoffice-fresh
      vlc
      mpv
# Dev Packages
      git
      rustup
      go
      nodePackages_latest.nodejs
# python3full
      pipx
      gnumake
      cmake
      autoconf
      automake
      pkg-config
      stow
# Theme Packages
      font-awesome
      powerline-fonts
      nitch
# Security Packages
      sbctl
      mokutil
      openssl
      openssh
      gnupg
      pass
      keepassxc
# Kernel Packages
      linux
      linuxHeaders
      linux-firmware
      mkinitcpio-nfs-utils
      basez
      ghc_filesystem
      glibc
      systemd
# Utility Packages
      bc
      xclip
      wl-clipboard
      xdg-utils
      xdg-user-dirs
      xdg-desktop-portal
      mesa
      vulkan-tools
      gpu-viewer
      inxi
      imagemagick
      ffmpeg_6-full
      yt-dlp
      qbittorrent-enhanced
      ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "25.05"; # Did you read the comment?

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
