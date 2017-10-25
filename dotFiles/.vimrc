set nocompatible              " be iMproved, required
filetype off                  " required

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
Plugin 'Valloric/YouCompleteMe'
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

" Color Schemes
Plugin 'tomasr/molokai'
Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on

" General
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

