if status is-interactive
end

set -gx LANG en_IN.UTF-8
set -gx LC_ALL en_IN.UTF-8
set -gx EDITOR "nvim"
set -gx TERM "kitty"
set -gx BROWSER "zen-browser"
if set -q TMUX
  set -gx TERM "tmux-256color"  # Inside tmux
else
  set -gx TERM "xterm-256color" # Outside tmux
end
set -gx COLORTERM "truecolor"
set -gx LS_COLORS "di=1;3;34:fi=0"

set -g fish_key_bindings fish_default_key_bindings
# function fish_hybrid_key_bindings --description \
# # "Vi-style bindings that inherit emacs-style bindings in all modes"
#     for mode in default insert visual
        # fish_default_key_bindings -M $mode
    # end
    # fish_vi_key_bindings --no-erase
# end
# set -g fish_key_bindings fish_hybrid_key_bindings
# set -g fish_key_bindings fish_vi_key_bindings
# set fish_cursor_default block
# set fish_cursor_insert line
# set fish_cursor_replace_one underscore
# set fish_cursor_replace underscore
# set fish_cursor_external line
# set fish_cursor_visual block

bind \en down-or-search
bind \ep up-or-search

function gacp
  git add .;git commit -m 's';git push
end

function fish_greeting
  random choice "Hello!" "Hi!" "Good Day!" "Howdy!"
end

function fish_title
    echo $argv[1] (prompt_pwd)
    pwd
end

# Editor Commands
alias v "vim"
alias vi "vim"
alias n "nvim"
alias sn "sudo nvim"

# Terminal Commands
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."
alias ...... "cd ../../../../.."
alias c "clear"
alias ls "eza -a --icons --grid"
alias ll "eza -la --icons --grid"

# Tmux commands
alias ta "tmux attach"
alias td "tmux dettach"
alias tns "tmux new-session"

# For Nix-OS only
alias rebel "bash ~/snix/scripts/rebuild"
alias uprebel "bash ~/snix/scripts/up-rebuild"
alias op-net "bash ~/snix/scripts/optimize-network"

# Entertainment
alias anime "bash ~/snix/scripts/ani-cli"
