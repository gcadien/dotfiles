set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/bundle')

Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vimwiki/vimwiki'
Plug 'Shougo/denite.nvim'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer' }
Plug 'zah/nim.vim'
Plug 'reedes/vim-pencil'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'godlygeek/tabular'
Plug 'rust-lang/rust.vim'
Plug 'timonv/vim-cargo'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sirtaj/vim-openscad'
call plug#end()

set number
set rtp+=$HOME/dotfiles/vim

syntax enable
set background=dark
colorscheme gruvbox
filetype plugin indent on
set directory^=$HOME/.vim/tmp//

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
au BufNewFile,BufRead *.nim set filetype=nim

let mapleader = ','

" VimWiki
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_list = [{'path': '~/newwiki/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]
nmap <leader>tt :VimwikiToggleListItem<CR>
" --- Vim Airline ---
let g:airline_powerline_fonts = 1


" -- YouCompleteMe --
let g:ycm_autoclose_preview_window_after_completion=1

let g:vim_markdown_preview_github=0
let g:ycm_semantic_triggers = {
	\   'java': [ 're!\w{2}' ]
	\ }
set clipboard=unnamed

set expandtab       " Tabs are spaces
set ignorecase      " Case insensitive search
set softtabstop=2   " Soft tabs 2 spaces
set ts=2
set shiftwidth=2
set number          " Show line numbers
set ruler           " Show cursor position

" Window movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


nnoremap <leader>d :NERDTreeToggle<CR>

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")
" Rust
let g:autofmt_autosave = 1
let g:UltiSnipsSnippetsDir = $HOME . '/dotfiles/vim/UltiSnips'
" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-s>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

let g:ycm_log_level = 'debug'

" Neovim Specific
if has('nvim')
  tnoremap <Esc><Esc> <C-\><C-n>
  tnoremap <M-1> <Esc>1
  tnoremap <A-1> <Esc>1
endif
