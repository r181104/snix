# Only run in interactive shells
if status is-interactive
  # ===== Core Environment Variables =====
  set -Ux EDITOR nvim
  set -Ux VISUAL nvim
  set -Ux PAGER less
  set -Ux MANPAGER "less -R"
  set -Ux TERM xterm-256color
  set -Ux LANG en_IN.UTF-8
  set -Ux LC_ALL en_IN.UTF-8
  set -Ux BAT_THEME Dracula
  set -Ux FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --preview-window=wrap"

  set -gx TERMINAL_FONT "JetBrainsMono NF"

  # ===== Development Variables =====
  set -Ux GOPATH $HOME/go
  set -Ux CARGO_HOME $HOME/.cargo
  set -Ux PYENV_ROOT $HOME/.pyenv

  # ===== Path Setup =====
  fish_add_path $HOME/.local/bin
  fish_add_path $CARGO_HOME/bin
  fish_add_path $GOPATH/bin
  fish_add_path $PYENV_ROOT/bin
  fish_add_path /usr/local/sbin

  # ===== Tool Initialization =====
  zoxide init fish | source

  # ===== Quality-of-Life Settings =====
  set -U fish_greeting "Yo Bro this is FISH"
  set -U fish_autosuggestion_enabled 1
  set -U fish_cursor_insert line
  
  # Enable true color support
  set -g fish_term24bit 1
  
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

  # Git Operation
  function gacp
    git add .;git commit -m 's';git push
  end

  # File operations
  function ls
    command ls -aFh --color=auto --group-directories-first $argv
  end

  function la; ls -Alh $argv; end
  function ll; ls -Fls $argv; end
  function rmd; rm -rfv $argv; end

  # Navigation utilities
  function ..; cd ..; end
  function ...; cd ../..; end
  function ....; cd ../../..; end
  function .....; cd ../../../..; end
  function bd; cd -; end

  # System monitoring
  function topcpu
    ps -eo pcpu,pid,user,args --sort=-pcpu | head -11
  end

  # Git utilities
  function git-clean
    git reflog expire --expire=now --all
    git gc --prune=now --aggressive
  end

  # ===== BASIC ABBREVIATIONS =====
  # Core abbreviations
  abbr home 'cd ~'
  abbr clr clear
  abbr c clear
  abbr cls clear
  abbr cp 'cp -i'
  abbr mv 'mv -i'
  abbr mkdir 'mkdir -p'
  
  # Editor shortcuts
  abbr n nvim
  abbr sn 'sudo nvim'
  abbr v vim
  abbr sv 'sudo vim'
  
  # System utilities
  abbr ping 'ping -c 5'
  abbr openports 'ss -tulpn'
  
  # Package management
  abbr rebel 'bash ~/snix/scripts/rebuild'
  abbr uprebel 'bash ~/snix/scripts/up-rebuild'
  abbr cwifi 'bash ~/snix/scripts/cwifi'
  
end
