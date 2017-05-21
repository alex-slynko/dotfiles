set showcmd " show current command

" We need a new leader
let mapleader = "\<Space>"

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

call plug#begin('~/.local/share/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries' }
Plug 'janko-m/vim-test'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-commentary'
call plug#end()

autocmd FileType go compiler go
autocmd! BufEnter *.go setlocal shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab

" vim-go setup
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_fmt_experimental = 1

let g:deoplete#sources#go#align_class = 1
nnoremap <unique> <expr> <CR> empty(&buftype) ? ':w<CR>' : '<CR>'
