""" neovim rc

""" Python3 VirtualEnv
let g:python3_host_prog = expand('/Users/jwdesch/.pyenv/shims/python')
let g:python_host_prog = expand('/usr/local/bin/python2')

""" plugins
let $VIM_OSX = system('uname -a | grep -i darwin') != ''

call plug#begin('~/.config/nvim/plugged')
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-obsession'

    Plug 'scrooloose/nerdtree'

    if $VIM_OSX
        Plug '/usr/local/opt/fzf'
    else
        Plug '~/fzf', {'dir' : '~/.fzf', 'do' : './install --all'}
    endif

    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch' : 'release'}

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
set nowritebackup

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


" toggle
nnoremap <silent><leader>e :NERDTreeToggle<CR>

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

" AUTOCOMPLETE
let g:coc_global_extensions = ['coc-clangd', 'coc-cmake', 'coc-json', 'coc-python', 'coc-yaml']
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gf <Plug>(coc-references)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

