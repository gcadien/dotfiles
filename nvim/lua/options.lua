vim.cmd("set termguicolors")
vim.opt.background = 'dark'

vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.clipboard="unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Window related mappings
vim.keymap.set('n', '<leader>wq', '<c-w>q')
vim.keymap.set('n', '<leader>wv', '<c-w>v')
vim.keymap.set('n', '<leader>ws', '<c-w>s')
vim.keymap.set('n', '<leader>wh', '<c-w>h')
vim.keymap.set('n', '<leader>wl', '<c-w>l')
vim.keymap.set('n', '<leader>wk', '<c-w>k')
vim.keymap.set('n', '<leader>wj', '<c-w>j')

-- Buffer related mappings
vim.keymap.set('n', '<leader>q', ':quit<CR>', {silent = true})
vim.keymap.set('n', '<leader>fs', ':write<CR>', {silent = true})
