let mapleader = " "
set nocompatible  " Use Vim settings, rather then Vi settings
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-fugitive'
Bundle 'kchmck/vim-coffee-script'
Bundle 'elzr/vim-json'
Bundle 'PProvost/vim-ps1'
Bundle 'thoughtbot/vim-rspec'

filetype plugin indent on     " required!
filetype on
syntax enable
set nobackup
set noswapfile
set nowritebackup
set history=500
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

au BufRead,BufNewFile *.md set filetype=markdown
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
