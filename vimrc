let mapleader = " "
set nocompatible  " Use Vim settings, rather then Vi settings
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'thoughtbot/vim-rspec'
Bundle 'kchmck/vim-coffee-script'

filetype plugin indent on     " required!
filetype on
syntax enable
set nobackup
set noswapfile
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
autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes
nnoremap <leader><leader> <c-^>

nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

au BufRead,BufNewFile *.md set filetype=markdown
