{ config, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
      ./modules/basic-pkgs.nix
    ];

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix-hak"; # Define your hostname.

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

  services.libinput.enable = true;

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
    wget
      neovim
      vim
      alacritty
      ghostty
  ];

  networking.firewall.enable = false;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
