
-- Window related mappings
vim.keymap.set('n', '<leader>wq', '<c-w>q')
vim.keymap.set('n', '<leader>wv', '<c-w>v')
vim.keymap.set('n', '<leader>ws', '<c-w>s')
vim.keymap.set('n', '<leader>wh', '<c-w>h')
vim.keymap.set('n', '<leader>wl', '<c-w>l')
vim.keymap.set('n', '<leader>wk', '<c-w>k')
vim.keymap.set('n', '<leader>wj', '<c-w>j')


local builtin = require('telescope.builtin')
-- Buffer related mappings
vim.keymap.set('n', '<leader>bb', builtin.buffers, {silent = true})
vim.keymap.set('n', '<leader>q', ':quit<CR>', {silent = true})
vim.keymap.set('n', '<leader>fs', ':write<CR>', {silent = true})
vim.keymap.set('n', '<leader>fo', builtin.find_files, {silent = true})
