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
alias l "eza -la --icons --grid"
