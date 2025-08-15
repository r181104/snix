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

  function fish_prompt
    set -l exit_code $status
    set -l dir (prompt_pwd)
    
    # Set colors
    set -l color_cwd (set_color blue)
    set -l color_lang (set_color cyan)
    set -l color_error (set_color red)
    set -l color_reset (set_color normal)
    
    # First line: user@host directory
    echo -n -s (whoami) "@" (hostname) " " $color_cwd $dir $color_reset
    if test -n "$lang_info"
      echo -n -s " " $color_lang "[" $lang_info "]" $color_reset
    end
    
    # Second line: status indicator
    if test $exit_code -ne 0
      echo -n -s $color_error "[$exit_code] ❯ " $color_reset
    else
      echo -n -s "❯ " 
    end
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
  
  # Display nitch after config loads
  if type -q nitch
    nitch
  end
end
