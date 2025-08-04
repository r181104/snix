" ==== CORE PERFORMANCE ====
set nocompatible      " Disable legacy Vi mode
syntax enable         " Enable syntax processing
filetype on           " Enable filetype detection
filetype indent on    " Load file-specific indent rules
set hidden            " Allow background buffers without saving
set ttyfast           " Optimize for fast terminals
set lazyredraw        " Don't redraw during macros/regops

" ==== VISUAL DESIGN (DRACULA HIGH-CONTRAST) ====
set termguicolors     " Enable true-color support

" Dracula base palette (high-contrast variant)
let g:dracula_bg = "#0d0d15"
let g:dracula_fg = "#f8f8f2"
let g:dracula_red = "#ff5555"
let g:dracula_green = "#50fa7b"
let g:dracula_yellow = "#f1fa8c"
let g:dracula_purple = "#bd93f9"
let g:dracula_cyan = "#8be9fd"

" Apply custom Dracula scheme
function! ApplyDraculaHC()
  " Global
  exec "hi Normal guibg=" . g:dracula_bg . " guifg=" . g:dracula_fg
  exec "hi LineNr guifg=" . g:dracula_purple . " guibg=" . g:dracula_bg
  exec "hi CursorLine guibg=#1e1e2e"
  exec "hi CursorLineNr guifg=" . g:dracula_yellow . " gui=bold"

  " Syntax highlighting
  exec "hi Comment guifg=" . g:dracula_cyan . " gui=italic"
  exec "hi String guifg=" . g:dracula_yellow
  exec "hi Identifier guifg=" . g:dracula_green
  exec "hi Function guifg=" . g:dracula_purple . " gui=bold"
  exec "hi Keyword guifg=" . g:dracula_red . " gui=bold"

  " UI elements
  exec "hi Pmenu guibg=#282a36 guifg=" . g:dracula_fg
  exec "hi PmenuSel guibg=" . g:dracula_purple . " guifg=#000000"
  exec "hi Search guibg=" . g:dracula_yellow . " guifg=#000000"
  exec "hi IncSearch guibg=" . g:dracula_red . " guifg=#ffffff"
  exec "hi MatchParen guibg=" . g:dracula_cyan . " guifg=#000000"

  " Gutter
  exec "hi SignColumn guibg=" . g:dracula_bg
  exec "hi FoldColumn guibg=" . g:dracula_bg
endfunction

call ApplyDraculaHC()  " Activate theme

" ==== EDITING ESSENTIALS ====
set number            " Show absolute line numbers
set relativenumber    " Show relative numbers (hybrid mode)
set cursorline        " Highlight current line
set scrolloff=8       " Keep 8 lines above/below cursor
set wrap              " Line wrapping enabled
set textwidth=0       " Disable automatic line breaking
set showcmd           " Show command in bottom bar
set showmatch         " Highlight matching brackets
set signcolumn=yes    " Always show sign column

" ==== INDENTATION & TABS ====
set tabstop=4         " Visual spaces per TAB
set shiftwidth=4      " Columns for auto-indent
set softtabstop=4     " Spaces inserted when pressing TAB
set expandtab         " Convert tabs to spaces
set smartindent       " Context-aware indenting
set autoindent        " Carry indentation to new lines

" ==== SEARCH BEHAVIOR ====
set incsearch         " Show matches while typing
set hlsearch          " Highlight all matches
set ignorecase        " Case-insensitive search
set smartcase         " Case-sensitive if uppercase used

" ==== PERFORMANCE TWEAKS ====
set noswapfile        " Disable swap files
set undofile          " Persistent undo history
set undodir=~/.vim/undo " Undo directory
set updatetime=100    " Faster UI updates
set synmaxcol=300     " Limit syntax highlighting to 300 cols

" ==== KEY MAPPINGS ====
let mapleader=" "     " Space as leader key

" Navigation
nnoremap <leader>h :nohl<CR>     " Clear search highlights

" Buffer management
nnoremap <leader>bn :bnext<CR>   " Next buffer
nnoremap <leader>bp :bprev<CR>   " Previous buffer
nnoremap <leader>bd :bdelete<CR> " Close buffer

" Window control
nnoremap <leader>sv <C-w>v<C-w>l " Vertical split
nnoremap <leader>sh <C-w>s       " Horizontal split

" Quality of life
nnoremap Y y$                    " Yank to end of line
nnoremap n nzzzv                 " Center search results
nnoremap N Nzzzv

" ==== KEYBINDINGS WITH DESCRIPTIONS ====

" File operations
nnoremap <leader>w :write<CR>            " [w]rite/save file
nnoremap <leader>q :quit<CR>             " [q]uit current window

" Universal escape (multi-mode)
inoremap jk <Esc>                        " jk → Escape (insert mode)
vnoremap jk <Esc>                        " jk → Escape (visual mode)
snoremap jk <Esc>                        " jk → Escape (select mode)
cnoremap jk <C-c>                        " jk → Abort command
tnoremap jk <C-\><C-n>                   " jk → Exit terminal mode
onoremap jk <Esc>                        " jk → Escape operator pending

" System clipboard
nnoremap <leader>y "+y                   " [y]ank to system clipboard
vnoremap <leader>y "+y

" Terminal
nnoremap <leader>ter :terminal<CR>
tnoremap <Esc> <C-\><C-n>                " Escape terminal mode

" Window navigation (tmux-style fallback)
nnoremap <C-h> <C-w>h                    " Move [h] left
nnoremap <C-j> <C-w>j                    " Move [j] down
nnoremap <C-k> <C-w>k                    " Move [k] up
nnoremap <C-l> <C-w>l                    " Move [l] right

" Git integration (fallback without plugins)
nnoremap <leader>git :!git status<CR>    " [git] status (shell fallback)

" ==== COMMENTING/UNCOMMENTING (PLUGIN-FREE) ====
" Toggle comments for multiple filetypes
function! ToggleComment()
  let comment_map = {
        \ 'vim': '"',
        \ 'python': '#',
        \ 'sh': '#',
        \ 'zsh': '#',
        \ 'javascript': '//',
        \ 'c': '//',
        \ 'cpp': '//',
        \ 'go': '//',
        \ 'lua': '--',
        \ 'sql': '--',
        \ 'ruby': '#',
        \ 'yaml': '#',
        \ 'conf': '#',
        \ 'fstab': '#',
        \ 'bash': '#',
        \ 'make': '#',
        \ 'cmake': '#'
        \ }

  let comment = get(comment_map, &filetype, '#')
  let regex = '^\s*' . comment
  let line = getline('.')

  if line =~ regex
    " Uncomment
    execute 's/' . regex . '//'
  else
    " Comment
    execute 's/^/' . comment . ' /'
  endif
endfunction

" Keybind for comment toggle (normal and visual modes)
nnoremap gcc :call ToggleComment()<CR>
  vnoremap gcc :call ToggleComment()<CR>

" ==== ENHANCED KEYBIND HELP ====
" Display keybind help with <leader>?
nnoremap <leader>? :echo "
  \ Space-w: Save file\n
  \ Space-q: Quit window\n
  \ jk: Universal escape\n
  \ Space-y: Yank to clipboard\n
  \ Space-ter: Open terminal\n
  \ Ctrl+h/j/k/l: Window nav\n
  \ Space-git: Git status
  \"<CR>

" ==== ADVANCED FEATURES ====
" Persistent cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" Auto-remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Custom status line
set laststatus=2
set statusline=
set statusline+=%#DraculaHC#                          " Color
set statusline+=\ %f\                                  " Filename
set statusline+=%m\                                    " Modified flag
set statusline+=%r\                                    " Readonly flag
set statusline+=%h\                                    " Help buffer flag
set statusline+=%w\                                    " Preview window flag
set statusline+=%=                                     " Right align
set statusline+=[%{&ff}]                               " File format
set statusline+=\ [%Y]                                 " File type
set statusline+=\ [%04l/%04L]                          " Line numbers

" Highlight group for statusline
hi DraculaHC guibg=#44475a guifg=#f8f8f2 gui=bold

" ==== TERMINAL FALLBACK ====
if !has('gui_running')
  set t_Co=256          " Force 256-color mode
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
