set nocompatible              " be iMproved, required
filetype off                  " required

set shell=/bin/bash

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Enable fzf
set rtp+=/usr/local/opt/fzf
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'w0rp/ale'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bling/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'elzr/vim-json'
Plugin 'honza/vim-snippets'
Plugin 'justinmk/vim-sneak'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
Plugin 'plasticboy/vim-markdown'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tyru/open-browser.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'fatih/vim-go'
Plugin 'davidhalter/jedi-vim'
Plugin 'joegesualdo/jsdoc.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'godlygeek/tabular'

" Color Schemes
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

" General
" global enable spell check
"set spell spelllang=en_us   " spell check go to highlighted word and "z=" to see list to turn off set nospell
setlocal spell spelllang=en_us
setlocal spellfile=$HOME/repos/Utils/dotFiles/vim-spell-en.utf-8.add
autocmd BufRead,BufNewFile *.md,*.txt setlocal spell  " enable spell check for certain files
set history=500 " how many lines history VIM remembers
filetype plugin on
filetype indent on
set autoread    " auto read when file is change from outside
nmap <leader>w :w!<cr>  " fast saving
set ffs=unix,dos,mac    " Unix as standard file type

" UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8


" Spaces & Tabs
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set lbr
set textwidth=120     " wrap lines after chars

" UI Config
set number      " enable number lines
set showcmd     " show command bar
set cursorline  " horizontal line where cursor is
set wildmenu    " visual autocomplete for command menu
set lazyredraw  " redraw ony when we need to
set showmatch   " highly matching [{()}]
set ruler       " always show current position
try
    colorscheme desert
catch
endtry

set background=dark

" Searching
set ignorecase  " ignore case when searching
set incsearch   " search as characters are entered
set hlsearch    " highlight matches
nnoremap <leader><space> :nohlsearch<CR>    " turn off search highly

" Folding
set foldenable  " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " nexted fold max
nnoremap <space> za     " space open/clse folds
set foldmethod=indent   " fold based on indent level

" Audio - disable annoying sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Files, Backups, Undo
set nobackup
set nowb
set noswapfile

" Enable NerdTree
autocmd vimenter * NERDTree

" Config NerdTree
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows= 1
let NERDTreeAutoDeleteBuffer = 1

" ALE Linters
let g:ale_linters = {
\   'java': ['checkstyle', 'javac', 'google-java-format', 'pmd'],
\   'javascript': ['eslint'],
\   'python': ['pylint'],
\   'c': ['cppcheck'],
\   'vim': ['vim-vint'],
\   'terraform': ['tflint'],
\   'make': ['checkmake'],
\   'css': ['prettier'],
\   'json': ['jq, jsonlint, prettier'],
\   'markdown': ['alex !!, prettier', 'proselint'],
\   'proto': ['protoc-gen-lint'],
\   'ymal': ['prettier'],
\   'go': ['gofmt', 'go vet !!', 'golint'],
\   'html': ['alex !!', 'htmlhint', 'proselint', 'tidy'],
\   'latex': ['alex !!', 'proselint'],
\   'xhtml': ['alex !!', 'proselint'],
\   'asciidoc': ['alex !!', 'proselint'],
\}

" ALE Fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'java': ['checkstyle', 'javac', 'google-java-format', 'pmd'],
\   'javascript': ['eslint'],
\   'python': ['pylint'],
\   'c': ['cppcheck'],
\   'vim': ['vim-vint'],
\   'terraform': ['tflint'],
\   'make': ['checkmake'],
\   'css': ['prettier'],
\   'json': ['jq, jsonlint, prettier'],
\   'markdown': ['alex !!, prettier', 'proselint'],
\   'proto': ['protoc-gen-lint'],
\   'ymal': ['prettier'],
\   'go': ['gofmt', 'go vet !!', 'golint'],
\   'html': ['alex !!', 'htmlhint', 'proselint', 'tidy'],
\   'latex': ['alex !!', 'proselint'],
\   'xhtml': ['alex !!', 'proselint'],
\   'asciidoc': ['alex !!', 'proselint'],
\}

" Python remove training white space
autocmd BufWritePre *.py :%s/\s\+$//e

" Set this variable to 1 to fix files when you save them.
" let g:ale_fix_on_save = 1

" Vim-Vint via Scrooloose/syntastic
" let g:syntastic_vim_checkers = ['vint']
