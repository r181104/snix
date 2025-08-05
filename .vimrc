set nocompatible
syntax enable
filetype on
filetype indent on
set hidden
set ttyfast
set lazyredraw
colorscheme ron
colorscheme retrobox

if has('gui_running')
  set transparency=5
else
endif
set termguicolors
if !has('gui_running')
  set t_Co=256
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
endif

set number
set relativenumber
set cursorline
set scrolloff=8
set sidescrolloff=8
set wrap
set linebreak
set showcmd
set showmatch
set signcolumn=yes
set virtualedit=block
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set autoindent
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
set noswapfile
set undofile
set undodir=~/.vim/undo
set updatetime=50
set synmaxcol=500
set ttimeoutlen=10

let mapleader=" "

nnoremap <silent> <leader>h :nohl<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>? :echo "Space-w: Save\nSpace-q: Quit\njk: Escape\nSpace-y: Yank\nSpace-t: Terminal\nSpace-l: Toggle list\nCtrl+hjkl: Window nav"<CR>

nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>

nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>sh <C-w>s
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap <leader>y :w !xclip -sel clip<CR><CR>
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>

inoremap jk <Esc>
vnoremap jk <Esc>
cnoremap jk <C-c>
tnoremap jk <C-\><C-n>

nnoremap <leader>t :terminal<CR>
tnoremap <Esc> <C-\><C-n>

nnoremap <leader>l :set list!<CR>

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

nnoremap gcc :call ToggleComment()<CR>
vnoremap gc :call ToggleComment()<CR>

augroup vimrc_autocmds
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
  autocmd BufWritePre * %s/\s\+$//e
augroup END

set listchars=tab:▸\ ,trail:•,nbsp:+,extends:»,precedes:«
set fillchars=vert:│,fold:·

set laststatus=2
set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %{toupper(mode())}\
set statusline+=\ %f\
set statusline+=%m%r%h%w
set statusline+=%=
set statusline+=[%{&ff}]
set statusline+=\ ◊\ %Y
set statusline+=\ %04l:%-4c\
set statusline+=\ %3p%%

set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*~,*.pyc,*.class

if has('mouse')
  set mouse=a
endif
