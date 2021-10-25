" NVIM CONFIG
"set nocompatible              " be iMproved, required
"filetype off                  " required

"lua require("plugins")

"syntax enable
"colorscheme gruvbox
"set background=dark
"filetype plugin indent on    " required

"set expandtab       " Tabs are spaces
"set ignorecase      " Case insensitive search
"set softtabstop=2   " Soft tabs 2 spaces
"set ts=2
"set shiftwidth=2
"set number          " Show line numbers
let g:pandoc#syntax#conceal#urls = 1
"let mapleader = " "

" --------- Files ---------
"noremap <leader>fs :write<CR>
"noremap <leader>ft :NvimTreeToggle<CR>

" vim-slime configuration
"let g:slime_target = "neovim"
"let g:airline_theme='gruvbox'


"noremap <silent> <leader>q :quit<CR>

" ---------- Buffers ---------
"noremap <silent> <leader>bb :Denite buffer<CR>

" ---------- Notes -----------
"noremap <leader>ne :NoteList<CR>
"noremap <leader>nq :NoteQuick<CR>

" ---------- Windows ---------
"noremap <leader>wq <c-w>q 
"noremap <leader>wv <c-w>v
"noremap <leader>ws <c-w>s
"noremap <leader>wh <c-w>h
"noremap <leader>wl <c-w>l
"noremap <leader>wk <c-w>k
"noremap <leader>wj <c-w>j


" ---------- Python ---------
noremap <leader>rf :w! !python % <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       ***  HERE BE PLUGINS  ***                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" -------- Markdown --------
"let g:markdown_fenced_languages = ['lua', 'java', 'python']
"set conceallevel=2

" Language Server configs.  TODO Move these to lua
lua << EOF
require'lspconfig'.pyright.setup{}
EOF

"lua << END
"require'lspconfig'.sumneko_lua.setup {
"  cmd = {"/usr/bin/lua-language-server"};
" settings = {
"  Lua = {
"    runtime = {
"      version = 'Lua 5.4',
"      path = {
"        '?.lua',
"        '?/init.lua',
"        vim.fn.expand'~/.luarocks/share/lua/5.4/?.lua',
"        vim.fn.expand'~/.luarocks/share/lua/5.4/?/init.lua',
"        '/usr/share/5.4/?.lua',
"        '/usr/share/lua/5.4/?/init.lua'
"      }
"    },
"    diagnostics = {
"      globals = {'vim', 'use_rocks'},
"    },
"    workspace = {
"      library = {
"        [vim.fn.expand'~/.luarocks/share/lua/5.4'] = true,
"        ['/usr/share/lua/5.4'] = true,
"        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
"        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
"      }
"    }
"  }
"} 
"}
"END

" --------- Julia -----------
"lua << END
"  require'lspconfig'.julials.setup({on_attach=on_attach_vim})
"END

" --------- Telescope -------
 "lua require'telescope'.load_extension('spiral')

" --------- Denite ----------
"autocmd FileType denite call s:denite_my_settings()
"function! s:denite_my_settings() abort
"  nnoremap <silent><buffer><expr> <CR>
"  \ denite#do_map('do_action')
"  nnoremap <silent><buffer><expr> q
"  \ denite#do_map('quit')
"  nnoremap <silent><buffer><expr> <Esc>
"  \ denite#do_map('quit')
"  nnoremap <silent><buffer><expr> d
"  \ denite#do_map('do_action', 'delete')
"  nnoremap <silent><buffer><expr> p
"  \ denite#do_map('do_action', 'preview')
"  nnoremap <silent><buffer><expr> i
"  \ denite#do_map('open_filter_buffer')
"  nnoremap <silent><buffer><expr> <C-o>
"  \ denite#do_map('open_filter_buffer')
"  nnoremap <silent><buffer><expr> <C-t>
"  \ denite#do_map('do_action', 'tabopen')
"  nnoremap <silent><buffer><expr> <C-v>
"  \ denite#do_map('do_action', 'vsplit')
"  nnoremap <silent><buffer><expr> <C-h>
"  \ denite#do_map('do_action', 'split')
"endfunction
"let g:airline_powerline_fonts = 1
"autocmd BufEnter *.lua lua require'completion'.on_attach()
"autocmd BufEnter *.py lua require'completion'.on_attach()
"autocmd BufEnter *.jl lua require'completion'.on_attach()
"autocmd BufEnter *.java lua require'completion'.on_attach()
"lua require'lspconfig'.sumneko_lua.setup{on_attach=require'completion'.on_attach}
"lua require'nvim_lsp'.julials.setup{on_attach=require'diagnostic'.on_attach}
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
"set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
