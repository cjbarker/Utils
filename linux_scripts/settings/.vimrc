" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility (emulation of old bugs)
set nocompatible

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" wrap lines at 120 chars. 80 is somewhat antiquated with nowadays displays.
set textwidth=120

" turn syntax highlighting on
syntax on

" turn line numbers on
set number

" spell check language only in local buffer
" activate via set spell
setlocal spell spelllang=en_us
" zg to add word to word list
" zw to reverse
" zug to remove word from word list
" z= to get list of possibilities
if has("win16") || has("win32") || has("win64")
    set spellfile=~\.dict.add
else
    set spellfile=~/.vim/dict.add
endif

" highlight matching braces
set showmatch

set hlsearch
set ruler
set confirm
set visualbell
set t_vb=
set mouse=a
set history=50

colorscheme torte
