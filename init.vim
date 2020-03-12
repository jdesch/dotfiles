""" neovim rc

""" Python3 VirtualEnv
let g:python3_host_prog = expand('/Users/jwdesch/.pyenv/shims/python')
let g:python_host_prog = expand('/usr/local/bin/python2')
""" plugins
call plug#begin('~/.config/nvim/plugged')
" Autocomplete
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'ervandew/supertab'
" Python support
    Plug 'deoplete-plugins/deoplete-jedi'
" C support
    Plug 'deoplete-plugins/deoplete-clang'
" ASM support
    Plug 'deoplete-plugins/deoplete-asm'
" Haskell support
    Plug 'neovimhaskell/haskell-vim'
call plug#end()

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
set updatetime=300
set signcolumn=yes

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

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

""" time savers
" execute line in shell, output back to line
noremap Q !!sh<CR>
" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
" ctags
command! MakeTags !ctags -R .

" HASKELL settings
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

"" Deoplete settings
" Supertab
let g:SuperTabDefaultCompletionType = '<TAB>'
" - «Deoplete requires Neovim with Python3 enabled»
let g:python3_host_prog       = '/usr/bin/python3'
let g:python3_host_skip_check = 1

autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#omni#functions    = {}
call deoplete#custom#option('auto_complete_delay', 250)

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Python autocompletion
let g:deoplete#sources#jedi#show_docstring = 1

"use fzf in vim
set rtp+=/usr/local/opt/fzf
