" ==== CORE PERFORMANCE ====
set nocompatible      " Disable legacy Vi mode
syntax enable         " Enable syntax processing
filetype on           " Enable filetype detection
filetype indent on    " Load file-specific indent rules
set hidden            " Allow background buffers without saving
set ttyfast           " Optimize for fast terminals
set lazyredraw        " Don't redraw during macros/regops

" ==== TRANSPARENT BACKGROUND ====
" Enable transparency support
if has('gui_running')
  set transparency=5   " For GUI versions (gvim, macvim)
else
  " For terminal-based Vim, transparency is handled by terminal settings
  " Set your terminal emulator to have a transparent background
endif

" ==== VISUAL DESIGN (SOFT ONEDARK WARMER) ====
set termguicolors     " Enable true-color support

" Softer OneDark Warmer palette
let g:onedark_bg = "NONE"        " Fully transparent background
let g:onedark_fg = "#b2b9c6"      " Softer foreground
let g:onedark_red = "#d18e9e"     " Softer red
let g:onedark_green = "#a8c9a0"   " Softer green
let g:onedark_yellow = "#e0c88f"  " Softer yellow
let g:onedark_blue = "#8ab6d0"    " Softer blue
let g:onedark_purple = "#c7a0d2"  " Softer purple
let g:onedark_cyan = "#88c9c0"    " Softer cyan
let g:onedark_white = "#d8dde8"   " Softer off-white

" Apply softer OneDark Warmer scheme
function! ApplyOneDarkWarm()
  " Global transparent settings
  exec "hi Normal guibg=" . g:onedark_bg . " guifg=" . g:onedark_fg
  exec "hi NonText guibg=" . g:onedark_bg

  " Line numbers with transparency
  exec "hi LineNr guifg=" . g:onedark_purple . " guibg=" . g:onedark_bg
  exec "hi CursorLineNr guifg=" . g:onedark_yellow . " gui=bold guibg=NONE"

  " Cursor line with soft highlight
  exec "hi CursorLine guibg=#2a303a gui=NONE"

  " Syntax highlighting with softer colors
  exec "hi Comment guifg=" . g:onedark_cyan . " gui=italic guibg=NONE"
  exec "hi String guifg=" . g:onedark_green . " guibg=NONE"
  exec "hi Identifier guifg=" . g:onedark_blue . " guibg=NONE"
  exec "hi Function guifg=" . g:onedark_yellow . " gui=bold guibg=NONE"
  exec "hi Keyword guifg=" . g:onedark_purple . " gui=bold guibg=NONE"

  " UI elements with softer contrast
  exec "hi Pmenu guibg=#3c424c guifg=" . g:onedark_white
  exec "hi PmenuSel guibg=" . g:onedark_blue . " guifg=#ffffff"
  exec "hi Search guibg=" . g:onedark_yellow . " guifg=#000000"
  exec "hi IncSearch guibg=" . g:onedark_red . " guifg=#ffffff"
  exec "hi MatchParen guibg=" . g:onedark_cyan . " guifg=#000000"

  " Gutter with transparency
  exec "hi SignColumn guibg=" . g:onedark_bg
  exec "hi FoldColumn guibg=" . g:onedark_bg

  " Special elements
  exec "hi Todo guibg=" . g:onedark_yellow . " guifg=#000000"

  " Borders and dividers for readability
  exec "hi VertSplit guifg=#3c424c guibg=NONE"
  exec "hi StatusLine guifg=#b2b9c6 guibg=#3c424c"
  exec "hi StatusLineNC guifg=#6c7280 guibg=#3c424c"

  " Cursor styling
  exec "hi Cursor guibg=#528bff guifg=NONE"
  set guicursor=n-v-c:block-Cursor
  set guicursor+=i-ci-ve:ver25-Cursor
  set guicursor+=r-cr-o:hor20-Cursor
endfunction

call ApplyOneDarkWarm()  " Activate theme

" ==== TERMINAL COMPATIBILITY ====
if !has('gui_running')
  set t_Co=256
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  " Set terminal cursor shape
  let &t_SI = "\<Esc>[6 q"  " Solid block in insert mode
  let &t_SR = "\<Esc>[4 q"  " Underline in replace mode
  let &t_EI = "\<Esc>[2 q"  " Block in normal mode

  " Fallback to 256-color palette if truecolor not supported
  if !has('termguicolors') || empty($COLORTERM)
    let g:onedark_bg = "NONE"
    let g:onedark_fg = "250"
    let g:onedark_red = "168"
    let g:onedark_green = "114"
    let g:onedark_yellow = "180"
    let g:onedark_blue = "110"
    let g:onedark_purple = "176"
    let g:onedark_cyan = "73"
    let g:onedark_white = "253"
  endif
endif

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
set undodir=~/.vim/undo " Undo directory (create this folder!)
set updatetime=100    " Faster UI updates
set synmaxcol=300     " Limit syntax highlighting to 300 cols

" ==== KEY MAPPINGS ====
let mapleader=" "     " Space as leader key

" Navigation
nnoremap <leader>h :nohl<CR>     " Clear search highlights
nnoremap <leader>e :Explore<CR>

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
" nnoremap <leader>y :w !xclip -sel clip<CR><CR>
vnoremap <leader>y :w !xclip -sel clip<CR><CR>

" File operations
nnoremap <leader>w :write<CR>    " Save file
nnoremap <leader>q :quit<CR>     " Quit window

" Universal escape
inoremap jk <Esc>                " Insert mode
vnoremap jk <Esc>                " Visual mode
cnoremap jk <C-c>                " Command mode
tnoremap jk <C-\><C-n>           " Terminal mode

" Terminal
nnoremap <leader>ter :terminal<CR>
tnoremap <Esc> <C-\><C-n>        " Escape terminal mode

" Window navigation
nnoremap <C-h> <C-w>h            " Move left
nnoremap <C-j> <C-w>j            " Move down
nnoremap <C-k> <C-w>k            " Move up
nnoremap <C-l> <C-w>l            " Move right

" ==== COMMENTING/UNCOMMENTING ====
function! ToggleComment()
  let comment_map = {
        \ 'vim': '"',
        \ 'python': '#',
        \ 'sh': '#',
        \ 'nix': '#',
        \ 'zsh': '#',
        \ 'javascript': '//',
        \ 'typescript': '//',
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
  let regex = '^\s*' . comment . '\s\?'
  let line = getline('.')

  if line =~ regex
    execute 's/' . regex . '//'
  else
    execute 's/^/' . comment . ' /'
  endif
endfunction

" Standard commenting keybinds
nnoremap gcc :call ToggleComment()<CR>
vnoremap gc :call ToggleComment()<CR>

" ==== KEYBIND HELP ====
nnoremap <leader>? :echo "
      \ Space-w: Save file\n
      \ Space-q: Quit window\n
      \ jk: Universal escape\n
      \ Space-y: Yank to clipboard\n
      \ Space-ter: Open terminal\n
      \ gcc/gc: Toggle comments\n
      \ Ctrl+h/j/k/l: Window nav\n
      \ Space-bn/bp/bd: Buffer nav\n
      \"<CR>

" ==== ADVANCED FEATURES ====
" Persistent cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" Auto-remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Custom status line
set laststatus=2
set statusline=
set statusline+=%#PmenuSel#                     " Color
set statusline+=\ %f\                           " Filename
set statusline+=%m%r%h%w                        " Flags
set statusline+=%=                              " Right align
set statusline+=[%{&ff}]                        " File format
set statusline+=\ [%Y]                          " File type
set statusline+=\ [%04l/%04L]                   " Line numbers

" ==== TERMINAL COMPATIBILITY ====
if !has('gui_running')
  set t_Co=256
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  " Set terminal cursor shape (may not work in all terminals)
  let &t_SI = "\<Esc>[6 q"  " Solid block in insert mode
  let &t_SR = "\<Esc>[4 q"  " Underline in replace mode
  let &t_EI = "\<Esc>[2 q"  " Block in normal mode
endif
