{ config, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
      ./modules/bspwm.nix
      ./modules/graphics.nix
      ./modules/basic-pkgs.nix
    ];

  networking.hostName = "nix-hak";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  users.users.hack = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "hack";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [
      bash
        zsh
        tree
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 8;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 8";
  };

  environment.shells = with pkgs; [ bash zsh ];
  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.nm-applet.enable = true;

  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  time.timeZone = "Asia/Kolkata";
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
  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
