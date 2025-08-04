local wk = require("which-key")
-- Window related mappings
--vim.keymap.set('n', '<leader>wq', '<c-w>q')
--vim.keymap.set('n', '<leader>wv', '<c-w>v')
--vim.keymap.set('n', '<leader>ws', '<c-w>s')
--vim.keymap.set('n', '<leader>wh', '<c-w>h')
--vim.keymap.set('n', '<leader>wl', '<c-w>l')
--vim.keymap.set('n', '<leader>wk', '<c-w>k')
--vim.keymap.set('n', '<leader>wj', '<c-w>j')

wk.add({
  { "<leader>fs", "<cmd>w<cr>",  desc = "Save file" },
  { "<leader>q", "<cmd>q<cr>",  desc = "Quit window" },
  { "<leader>wh", "<c-w>h", desc = "Window left" },
  { "<leader>wl", "<c-w>l", desc = "Window right" },
  { "<leader>wk", "<c-w>j", desc = "Window up" },
  { "<leader>wj", "<c-w>k", desc = "Window down" },
})
