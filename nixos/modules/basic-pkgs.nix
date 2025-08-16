{ config, pkgs, lib, ... }:

{
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    stow
    curl
    starship
    zed-editor
    tmux
    alacritty
    ghostty
    foot
    kitty
    fzf
    zoxide
    peco
    eza
    ghq
    lazygit
    wl-clipboard
    bc
    xclip
    xdg-utils
    xdg-user-dirs
    xdg-desktop-portal
    inxi
    imagemagick
    ffmpeg
    yt-dlp
    qbittorrent
    blueman
    bluez
    brightnessctl
    pavucontrol
    acl
    alsa-utils
    alsa-plugins
    alsa-lib
    pipewire
    usbutils
    openssh
    ripgrep
    bat
    btop
    htop
    powertop
    tree
    which
    rsync
    unzip
    zip
    gzip
    p7zip
    black
    stylua
    prettier
    astyle
    gcc
    shfmt
    lua-language-server
    libreoffice-fresh
    vlc
    mpv
    rustup
    go
    python3Full
    powerline-fonts
    nitch
    brave
    jamesdsp
    nodePackages_latest.nodejs
    sddm-astronaut
    kdePackages.qtmultimedia
    kdePackages.qtsvg
    kdePackages.qtdeclarative
    kdePackages.qt5compat
    ollama
    libinput-gestures
    bibata-cursors
    killall
    lshw
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
