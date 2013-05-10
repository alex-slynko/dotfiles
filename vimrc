set nocompatible  " Use Vim settings, rather then Vi settings
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround'

filetype plugin indent on     " required!
filetype on
set nobackup
set nowritebackup
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
set tabpagemax=30

" Display extra whitespace
set list listchars=tab:»·,trail:·

