# Set environment variables
set -gx EDITOR nvim
set -gx TERM kitty
set -gx BROWSER zen-browser
set -gx LANG en_IN.UTF-8
set -gx LC_ALL en_IN.UTF-8
set -gx COLORTERM truecolor
set -gx LS_COLORS "di=1;3;34:fi=0"
set -gx __GL_SHADER_DISK_CACHE_SKIP_CLEANUP 1
set -gx __GL_THREADED_OPTIMIZATIONS 1
set -gx DXVK_HUD fps
set -gx MANGOHUD 1
set -gx LIBVA_DRIVER_NAME nvidia
set -gx VDPAU_DRIVER nvidia

# History configuration
set -g fish_history session
set -g fish_hist_size 10000
set -g fish_history_max_lines 10000

# Zoxide initialization
zoxide init fish | source
alias cd=z

# fzf configuration
set -g FZF_PREVIEW_FILE_CMD "eza --icons --color=always --icons -la"
set -g FZF_PREVIEW_DIR_CMD "eza --icons --color=always --icons -la"
set -g FZF_DEFAULT_OPTS "--layout=reverse --border --height=40%"

# ==========================================
#           eza --icons (MODERN LS REPLACEMENT)
# ==========================================
alias ls="eza --icons -a --color=always --icons --group-directories-first"
alias l="eza --icons -F"
alias la="eza --icons -aF"
alias ll="eza --icons -l --git --no-user --time-style=long-iso"
alias lla="eza --icons -la --git --no-user --time-style=long-iso"
alias lt="eza --icons -T --level=2"
alias lta="eza --icons -Ta --level=2"
alias tree="eza --icons -T"

# ==========================================
#           SYSTEM ALIASES
# ==========================================
alias clr="clear"
alias c="clear"
alias cp="cp -i"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias rmd="rm -rfv"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias home="cd ~"
alias bd="cd -"

# Editor shortcuts
alias n="nvim"
alias sn="sudo nvim"
alias v="vim"
alias sv="sudo vim"

# System info
alias df="eza --icons -aFh"
alias du="du -h -c"
alias free="free -m"
alias ps="ps auxf"
alias p="ps aux | grep -i"
alias topcpu="ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias openports="netstat -nape --inet"
alias diskspace="du -S | sort -n -r | more"
alias folders="du -h --max-depth=1"
alias mountedinfo="df -hT"
alias checkcommand="type -t"

# System control
alias reboot="systemctl reboot"
alias shutdown="shutdown now"
alias logout="loginctl kill-session \$XDG_SESSION_ID"

# Package management
alias rebel="bash ~/snix/scripts/rebuild"
alias uprebel="bash ~/snix/scripts/up-rebuild"
alias mirror-rating="rate-mirrors --entry-country=IN --protocol=https arch | sudo tee /etc/pacman.d/mirrorlist"

# Development
alias gc="git commit -m"
alias ga="git add ."
alias gp="git push"
alias gclean="git reflog expire --expire=now --all; git gc --prune=now --aggressive"

# Utilities
alias f="fzf --preview='bat {}' --bind 'enter:execute(nvim {})'"
alias h="history | grep -i"
alias kssh="kitty +kitten ssh"
alias web="cd /var/www/html"
alias da="date '+%Y-%m-%d %A %T %Z'"
alias anime="~/stecore/scripts/ani-cli"
alias random-lock="betterlockscreen -u ~/Wallpapers/Pictures --fx blur -l"
alias op-net="bash ~/snix/scripts/optimize-network"

# Fix Home/End keys
bind \e\[H beginning-of-line
bind \e\[F end-of-line
bind \e\[3~ delete-char

# History search
bind \cp history-search-backward
bind \cn history-search-forward

# Cycling through command history with Alt+p and Alt+n
bind \en down-or-search
bind \ep up-or-search

# ==========================================
#           HELPER FUNCTIONS
# ==========================================
function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

function mkcd
    mkdir -p $argv && cd $argv
end

function treed
    eza --icons --tree --level=$argv[1] $argv[2..]
end

function freshclam
    sudo freshclam
end

function extract
    switch $argv[1]
        case *.tar.bz2; tar xvjf $argv[1]
        case *.tar.gz; tar xvzf $argv[1]
        case *.bz2; bunzip2 $argv[1]
        case *.rar; unrar x $argv[1]
        case *.gz; gunzip $argv[1]
        case *.tar; tar xvf $argv[1]
        case *.tbz2; tar xvjf $argv[1]
        case *.tgz; tar xvzf $argv[1]
        case *.zip; unzip $argv[1]
        case *.Z; uncompress $argv[1]
        case *.7z; 7z x $argv[1]
        case *; echo "Unknown format"
    end
end

# ==========================================
#           TMUX ALIASES
# ==========================================
alias tns="tmux new -s"
alias ta="tmux attach"
alias td="tmux detach"

# Initialize SSH agent
if [ -z "$SSH_AUTH_SOCK" ]
    fish_ssh_agent
    ssh-add ~/.ssh/id_rsa >/dev/null 2>&1
end

# Terminal-specific settings
if set -q TMUX
    set -gx TERM tmux-256color
else
    set -gx TERM xterm-256color
end

# name: sashimi
function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -g red (set_color -o red)
  set -g blue (set_color -o blue)
  set -l green (set_color -o green)
  set -g normal (set_color normal)

  set -l ahead (_git_ahead)
  set -g whitespace ' '

  if test $last_status = 0
    set initial_indicator "$green◆"
    set status_indicator "$normal❯$cyan❯$green❯"
  else
    set initial_indicator "$red✖ $last_status"
    set status_indicator "$red❯$red❯$red❯"
  end
  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]

    if test (_git_branch_name) = 'master'
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($red$git_branch$normal)"
    else
      set -l git_branch (_git_branch_name)
      set git_info "$normal git:($blue$git_branch$normal)"
    end

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end

  # Notify if a command took more than 5 minutes
  if [ "$CMD_DURATION" -gt 300000 ]
    echo The last command took (math "$CMD_DURATION/1000") seconds.
  end

  echo -n -s $initial_indicator $whitespace $cwd $git_info $whitespace $ahead $status_indicator $whitespace
end

function _git_ahead
  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
  if [ $status != 0 ]
    return
  end
  set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
  set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
  switch "$ahead $behind"
    case ''     # no upstream
    case '0 0'  # equal to upstream
      return
    case '* 0'  # ahead of upstream
      echo "$blue↑$normal_c$ahead$whitespace"
    case '0 *'  # behind upstream
      echo "$red↓$normal_c$behind$whitespace"
    case '*'    # diverged from upstream
      echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
  end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end
