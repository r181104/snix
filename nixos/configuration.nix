{ config, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
      ./modules/basic-pkgs.nix
      ./modules/qtilewm-pkgs.nix
    ];

  basic-pkgs.enable = true;
  qtilewm-pkgs.enable = true;

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 8;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 8";
  };

  networking.hostName = "nix-hak";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

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

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.libinput.enable = true;
  services.udisks2.enable = true;

  hardware.nvidia = {
    open = false;
  };

  security.polkit.enable = true;

  environment.shells = with pkgs; [ bash zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  users.users.hack = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "hack";
    extraGroups = [ "networkmanager" "wheel" "kvm" ];
    packages = with pkgs; [
      fish
        tree
    ];
  };

  programs.firefox.enable = true;

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
