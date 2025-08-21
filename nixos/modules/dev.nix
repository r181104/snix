{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Development Tools
    neovim
    vim
    shellcheck
    zed-editor
    tmux
    fzf
    lazygit
    rsync
    gcc
    rustup
    go
    python3Full
    uv
    nodePackages_latest.nodejs
    ollama
    pciutils

    # Servers
    lua-language-server
    python313Packages.python-lsp-server
    gopls
    nixd
    vscode-langservers-extracted
    hyprls

    # Formatters
    stylua
    prettier
    prettierd
    black
    isort
    gotools
    shfmt
    yamlfmt
    clang-tools
    google-java-format
    python313Packages.sqlfmt
    alejandra
  ];
}
