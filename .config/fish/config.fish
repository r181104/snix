if status is-interactive
end

bind \en down-or-search
bind \ep up-or-search

function gacp
  git add .;git commit -m 's';git push
end

# Editor Commands
alias v "vim"
alias vi "vim"
alias n "nvim"
alias sn "sudo nvim"

# Terminal Commands
alias c "clear"
alias ls "eza -a --icons --grid"
alias ll "eza -la --icons --grid"

# For Nix-OS only
alias rebel "bash ~/snix/scripts/rebuild"
alias uprebel "bash ~/snix/scripts/up-rebuild"
alias op-net "bash ~/snix/scripts/optimize-network"

# Entertainment
alias anime "bash ~/snix/scripts/ani-cli"
