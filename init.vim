""" neovim rc

""" Python3 VirtualEnv
let g:python3_host_prog = expand('/usr/local/bin/python3')

""" General
syntax on
set encoding=utf-8
set fileencoding=utf-8
set ttyfast
set lazyredraw
set cursorline
set hidden
set mouse=a

set wildmenu
set wildmode=list:longest
set path+=**

""" Visual stuff
set termguicolors
set t_Co=256
colorscheme NeoSolarized
set background=dark
set number
set laststatus=2
set showmatch

set invlist
set list
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:❯,precedes:❮

""" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" copy and paste to/from vIM and the clipboard
nnoremap <C-y> +y
vnoremap <C-y> +y
nnoremap <C-p> +P
vnoremap <C-p> +P

" access system clipboard
set clipboard=unnamed

" swapfiles location
set backupdir=/tmp/
set directory=/tmp/

""" Indentation
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

""" time savers
" execute line in shell, output back to line
noremap Q !!sh<CR>
" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
" ctags
command! MakeTags !ctags -R .
