{ config, pkgs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
    ];

  networking.hostName = "nix-hak";
  programs.nm-applet.enable = true;
  networking.networkmanager.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hack = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "hack";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      bash
        zsh
        tree
    ];
  };

# Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 8;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 8";
  };
# Shell configuration
  environment.shells = with pkgs; [ bash zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  programs.firefox.enable = true;
# To allow unfree for google-chrome 
  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

# Enable the X11 windowing system.
  services.xserver.enable = true;

# Enable the Deepin Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
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
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.libinput.enable = true;
# For Automounting usb's etc.
  services.udisks2.enable = true;
  services.udev.extraRules = ''
# Example: Mount USB drives to /media/<label> automatically
    ACTION=="add", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /media/%E{ID_FS_LABEL}"
    '';
  security.polkit.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  networking.firewall.enable = true;

# $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
      wget
      stow
      (pkgs.git.override { withLibsecret = false; })
      curl
      neovim
      tmux
      alacritty
      ghostty
      foot
      kitty
      fzf
      zoxide
      nodePackages_latest.nodejs
  ];

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

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
