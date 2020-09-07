syntax enable
runtime macros/matchit.vim
filetype on
filetype plugin indent on

set showcmd " show current command

" We need a new leader
let mapleader = " "

set splitright
set splitbelow

if has('persistent_undo')
  set undofile
  set undolevels=10000
  set undodir=~/.vim/.undo
endif

set swapfile                    " Keep swapfiles
set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp
set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp
set history=10000

set laststatus=2  " Always display the status line

set tabpagemax=30 " Open 30 files using vim -p

" Spaces win
set tabstop=2
set shiftwidth=2 " Tabs under smart indent
set expandtab

set autowrite     " write on running commands
set backspace=indent,eol,start

call plug#begin('~/.local/share/nvim/plugged')

Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries' }
Plug 'janko-m/vim-test'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-projectionist'
Plug 'tomasr/molokai'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \}
call plug#end()

autocmd FileType go compiler go
autocmd! BufEnter *.go setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
autocmd Filetype groovy setlocal tabstop=4

let g:deoplete#sources#go#align_class = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'yaml':  ['prettier', 'yamlfix'],
\   'ruby': ['rubocop', 'rufo', 'standardrb' ],
\   'sh': ['shfmt']
\ }
"
" save on enter
nnoremap <unique> <expr> <CR> empty(&buftype) ? ':w<CR>' : '<CR>'

" set wildmode=list:longest " use emacs-style tab completion when selecting files, etc
set wildmenu " show menu for files
set path+=**
set wildignore+=Godeps/*,vendor/*

" Mouse {{{
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes
" }}}

let g:netrw_banner=0 " hide netrw banner
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell
autocmd BufNewFile,BufRead *.gitconfig-shared gitconfig

let g:rehash256 = 1
let g:loaded_python_provider = 1 " disable python
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
