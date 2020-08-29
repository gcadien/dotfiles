set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()
Plug 'neovim/nvim-lsp'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'gruvbox-community/gruvbox'
Plug 'jpalardy/vim-slime'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

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

let mapleader = " "

" vim-slime configuration
let g:slime_target = "neovim"
let g:airline_theme='gruvbox'
" key bindings for quickly moving between windows
" h left, l right, k up, j down
noremap <leader>h <c-w>h
noremap <leader>l <c-w>l
noremap <leader>k <c-w>k
noremap <leader>j <c-w>j

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       ***  HERE BE PLUGINS  ***                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
autocmd BufEnter * lua require'completion'.on_attach()
lua require'nvim_lsp'.julials.setup{on_attach=require'diagnostic'.on_attach}
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
