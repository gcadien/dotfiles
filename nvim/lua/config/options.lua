vim.cmd("set termguicolors")
vim.cmd("colorscheme gruvbox")
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
--vim.keymap.set('n', '<leader>wq', '<c-w>q')
--vim.keymap.set('n', '<leader>wv', '<c-w>v')
--vim.keymap.set('n', '<leader>ws', '<c-w>s')
--vim.keymap.set('n', '<leader>wh', '<c-w>h')
--vim.keymap.set('n', '<leader>wl', '<c-w>l')
--vim.keymap.set('n', '<leader>wk', '<c-w>k')
--vim.keymap.set('n', '<leader>wj', '<c-w>j')

-- Buffer related mappings
--vim.keymap.set('n', '<leader>q', ':quit<CR>', {silent = true})
--vim.keymap.set('n', '<leader>fs', ':write<CR>', {silent = true})

-- Telescope mappings
--local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
--vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Toggleterm mappings
--vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { desc = 'Toggle terminal' })

-- Treesitter mappings - These are quit and dirty mappings to run tree-sitter cli in a terminal
--vim.keymap.set('n', '<leader>tsg', ':TermExec cmd="tree-sitter generate"<CR>', { desc = 'Run tree-sitter generate' })
--vim.keymap.set('n', '<leader>tst', ':TermExec cmd="tree-sitter test"<CR>', { desc = 'Run tree-sitter test' })

--function _G.set_terminal_keymaps()
--  print("Setting terminal keymaps")
--  local opts = {buffer = 0}
--  vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], opts)
--  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
--  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
--  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
--  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
--  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
--  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
--end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
--vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
