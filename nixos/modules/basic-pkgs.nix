{ config, pkgs, lib, ... }:

{
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Development Tools
    vim
    neovim
    shellcheck
    stow
    starship
    zed-editor
    tmux
    fzf
    zoxide
    peco
    eza
    ghq
    lazygit
    ripgrep
    bat
    tree
    which
    rsync
    black
    stylua
    prettier
    astyle
    gcc
    shfmt
    lua-language-server
    rustup
    go
    python3Full
    nodePackages_latest.nodejs
    ollama

    # Terminal Emulators
    alacritty
    ghostty
    foot
    kitty

    # System Utilities
    wget
    curl
    wl-clipboard
    bc
    xclip
    xdg-utils
    xdg-user-dirs
    xdg-desktop-portal
    inxi
    killall
    lshw
    usbutils
    openssh
    unzip
    zip
    gzip
    p7zip

    # System Monitoring
    btop
    htop
    powertop

    # Multimedia
    imagemagick
    ffmpeg
    yt-dlp
    vlc
    mpv
    kdePackages.qtmultimedia
    kdePackages.qtsvg
    kdePackages.qtdeclarative
    kdePackages.qt5compat

    # Bluetooth/Audio
    blueman
    bluez
    brightnessctl
    pavucontrol
    acl
    alsa-utils
    alsa-plugins
    alsa-lib
    pipewire
    jamesdsp

    # Applications
    qbittorrent
    libreoffice-fresh
    brave

    # UI/Theming
    powerline-fonts
    nitch
    sddm-astronaut
    bibata-cursors
    libinput-gestures

    # Git (special override)
    (pkgs.git.override { withLibsecret = false; })
  ];
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.nm-applet.enable = true;
}
