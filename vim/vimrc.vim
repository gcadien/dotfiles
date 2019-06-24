call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'sirtaj/vim-openscad'
Plug 'morhetz/gruvbox'
Plug 'sbdchd/neoformat'
Plug 'vim-airline/vim-airline'
call plug#end()

set rtp+=$HOME/dotfiles/vim
syntax on
filetype plugin indent on
syntax enable
colorscheme gruvbox
set background=dark
let mapleader = ','
nnoremap <leader>d :NERDTreeToggle<CR>
" Next buffer
nnoremap <leader>n :bn<CR>
" Previous buffer
nnoremap <leader>p :bp<CR>
nnoremap <leader>b :CtrlPBuffer<CR>     " Only search buffers
" Indent with no tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" No swap file
set noswapfile

" Neovim Terminal
if has("nvim")
  :tnoremap <Esc> <C-\><C-n>
endif

let g:UltiSnipsSnippetsDir = $HOME . '/dotfiles/vim/UltiSnips'
" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-s>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

let g:ycm_server_log_level = 'debug'

let g:neoformat_java_google = {
            \ 'exe': 'java',
            \ 'args': ['-jar /home/geoff/lib/google-java-format-1.6-all-deps.jar -'],
            \ 'stdin': 1,
            \ }

let g:neoformat_enabled_java = ['google']
" let g:solarized_termcolors=256
