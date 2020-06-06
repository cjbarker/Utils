filetype off                  " required

set shell=/bin/bash

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Enable fzf
set runtimepath+=/usr/local/opt/fzf
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'w0rp/ale'
Plugin 'sheerun/vim-polyglot'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'elzr/vim-json'
Plugin 'honza/vim-snippets'
Plugin 'justinmk/vim-sneak'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
Plugin 'plasticboy/vim-markdown'
Plugin 'lervag/vimtex'
Plugin 'mechatroner/rainbow_csv'
Plugin 'ap/vim-css-color'
Plugin 'luochen1990/rainbow'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/gv.vim'
Plugin 'tyru/open-browser.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'fatih/vim-go'
Plugin 'leafgarland/typescript-vim'
Plugin 'ianks/vim-tsx'
Plugin 'joegesualdo/jsdoc.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'godlygeek/tabular'
Plugin 'rhysd/vim-grammarous'       " GrammarCheck using LanguageTool

" Color Schemes
Plugin 'junegunn/seoul256.vim'
" Unified color scheme (default: dark)
colo seoul256
set background=dark

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on

" General Various Settings
" Redraw after executing the function. Helps w/ performance
set lazyredraw
set regexpengine=1

" global enable spell check
set spell spelllang=en_us   " spell check go to highlighted word and "z=" to see list to turn off set nospell
setlocal spell spelllang=en_us
setlocal spellfile=$HOME/repos/Utils/dotFiles/vim-spell-en.utf-8.add

augroup buf
    autocmd BufRead,BufNewFile *.md,*.txt setlocal spell  " enable spell check for certain files
    " Any file remove training white space
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

set history=500 " how many lines history VIM remembers
filetype plugin on
filetype indent on
set autoread    " auto read when file is change from outside
nmap <leader>w :w!<cr>  " fast saving
set fileformats=unix,dos,mac    " Unix as standard file type

" UTF-8 encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" Spaces & Tabs
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set wrap
set linebreak
set nolist
set textwidth=120     " wrap lines after chars

" UI Config
set number      " enable number lines
set showcmd     " show command bar
set cursorline  " horizontal line where cursor is
set wildmode=longest,list " tab completion for files/buffers
set wildmenu    " visual autocomplete for command menu
set lazyredraw  " redraw ony when we need to
set showmatch   " highly matching [{()}]
set ruler       " always show current position
set mouse+=a " enable mouse mode (scrolling, selection, etc)
if match($TERM, 'screen')==1
    set ttymouse=xterm2 " tmux knows the extended mouse mode
endif

" Searching
set ignorecase  " ignore case when searching
set smartcase   " use case if any caps used
set incsearch   " search as characters are entered
set hlsearch    " highlight matches
nnoremap <leader><space> :nohlsearch<CR>    " turn off search highly

" Undo
set undofile    " Maintain undo history between sessions
set undodir=~/.vim/undodir

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
set timeoutlen=500

" Disable sound on errors on MacVim
if has('gui_macvim')
    augroup macvim
        autocmd GUIEnter * set vb t_vb=
    augroup END
endif

" Files, Backups, Undo
set nobackup
set nowritebackup
set noswapfile

" Netrw
" https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

" Scrooloose/syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Vim-Vint via Scrooloose/syntastic
let g:syntastic_vim_checkers = ['vint']
let g:syntastic_vim_vint_exe = 'LC_CTYPE=UTF-8 vint'

" ALE Linters
let g:ale_linters = {
\   'java': ['checkstyle', 'javac', 'google-java-format', 'pmd'],
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'tslint'],
\   'vue': ['eslint'],
\   'python': ['pylint'],
\   'c': ['cppcheck'],
\   'vim': ['vint'],
\   'terraform': ['tflint'],
\   'make': ['checkmake'],
\   'css': ['prettier'],
\   'json': ['jq, jsonlint, prettier'],
\   'markdown': ['alex !!, prettier', 'proselint'],
\   'proto': ['protoc-gen-lint'],
\   'ymal': ['prettier'],
\   'go': ['gofmt', 'go vet', 'golint'],
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
\   'typescript': ['prettier'],
\   'vue': ['eslint'],
\   'scss': ['prettier'],
\   'python': ['pylint'],
\   'c': ['cppcheck'],
\   'vim': ['vint'],
\   'terraform': ['tflint'],
\   'make': ['checkmake'],
\   'css': ['prettier'],
\   'json': ['jq, jsonlint, prettier'],
\   'markdown': ['alex !!, prettier', 'proselint'],
\   'proto': ['protoc-gen-lint'],
\   'ymal': ['prettier'],
\   'go': ['gofmt', 'go vet', 'golint'],
\   'html': ['alex !!', 'htmlhint', 'proselint', 'tidy'],
\   'latex': ['alex !!', 'proselint'],
\   'xhtml': ['alex !!', 'proselint'],
\   'asciidoc': ['alex !!', 'proselint'],
\}

let g:ale_lint_on_text_changed = 0
" Set this variable to 1 to fix files when you save them.
"let g:ale_fix_on_save = 1

" Vim Markdown
let g:markdown_fenced_languages = [
    \ 'bash=sh',
    \ 'c',
    \ 'coffee',
    \ 'erb=eruby',
    \ 'javascript',
    \ 'json',
    \ 'perl',
    \ 'python',
    \ 'ruby',
    \ 'yaml',
    \ 'go',
\]
