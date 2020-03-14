""" neovim rc

""" Python3 VirtualEnv
let g:python3_host_prog = expand('/Users/jwdesch/.pyenv/shims/python')
let g:python_host_prog = expand('/usr/local/bin/python2')

""" plugins
let $VIM_OSX = system('uname -a | grep -i darwin') != ''

call plug#begin('~/.config/nvim/plugged')
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'

    if $VIM_OSX
        Plug '/usr/local/opt/fzf'
    else
        Plug '~/fzf', {'dir' : '~/.fzf', 'do' : './install --all' }
    endif

    Plug 'junegunn/fzf.vim'
call plug#end()

""" General
let mapleader=' '
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
set wildignore+=.git,.DS_Store

""" Visual stuff
set termguicolors
set t_Co=256
colorscheme NeoSolarized
set background=dark
set number
set laststatus=2
set showmatch
set signcolumn=yes

set invlist
set list
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:❯,precedes:❮

""" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" access system clipboard
set clipboard+=unnamedplus

" no swaps/backups
set nobackup
set noswapfile

""" Indentation
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

"""better substitution
if exists('&inccommand')
    set inccommand=split "Nvim specific
endif

" split to the right or below current
set splitright
set splitbelow

""" vim fixes
""" make Y consistent with C and D
nnoremap Y y$
""" u to undo U to redo, easier
nnoremap U <C-r>
""" Wrapped lines work...
nnoremap j gj
nnoremap k gk

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

""" Netrw act as file menu

" set autochdir 
let g:netrw_banner          = 0     "No Banner
let g:netrw_winsize         = 20    "20% of the screen
let g:netrw_liststyle       = 3     "dir listing style
let g:netrw_altv            = 1     "split to the right
let g:netrw_cursor          = 1     "cursor graphics
let g:netrw_browse_split    = 4     "How windows open (use prev window)
"""
let g:NetrwIsOpen=0  "for toggling powers

" you can quit the explorer
autocmd FileType netrw setl bufhidden=wipe

"toggle powers
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Vexplore
    endif
endfunction

" start open
augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * :call ToggleNetrw()
augroup END

" toggle
noremap <silent><leader>e :call ToggleNetrw()<CR>

"fzf 
let g:fzf_layout = { 'down' : '~20%' }
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'ctags -R'

" Shortcuts
"
" [F]ile Find
nmap <silent> <leader>f :FZF<CR>
" [B]uffer Find
nmap <silent> <leader>b :Buffers<CR>
" [L]ine Find
nmap <silent> <leader>l :Rg<CR>
" [T]ag find
nmap <silent> <leader>t :Tags<CR>
"" nvim [H]elp Find
nmap <silent> <leader>h :Helptags<CR>
" toggle between buffers
nnoremap <leader><leader> <c-^>

" Mapping selecting mappings
" Note: figure out what vim has bound
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
