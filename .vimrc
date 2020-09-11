" .vimrc
" License: Public Domain or NYSL

set nocompatible " this is vim, not vi

filetype on

syntax on
"filetype plugin indent on

set title
set ruler
set number

set showmatch
set tabstop=2
set expandtab
set smartindent
set autoindent
set backspace=indent,eol,start
set shiftwidth=4

set nowrapscan
set incsearch
set ignorecase
set smartcase " search in ignore-case, unless the buffer starts UPPERs

set hlsearch
set showmatch
set showmode

set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932
