" NVIM CONFIG
set nocompatible              " be iMproved, required
filetype off                  " required

lua require("plugins")

syntax enable
colorscheme gruvbox
set background=dark
filetype plugin indent on    " required

set expandtab       " Tabs are spaces
set ignorecase      " Case insensitive search
set softtabstop=2   " Soft tabs 2 spaces
set ts=2
set shiftwidth=2
set number          " Show line numbers
let g:pandoc#syntax#conceal#urls = 1
let mapleader = " "

lua require("completion")
augroup lsp
  au!
  au FileType java lua require'lsp.java'
  "au FileType java lua require'lsp.java'.start_jdt()
augroup end
