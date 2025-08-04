vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.lazy")
require("config.keymaps")
require("config.options")


vim.api.nvim_create_autocmd("FileType", {
	pattern = { "europa" },
	callback = function()
		print("FileType callback " .. vim.bo.filetype)
	end,
})

-- This is a hard-coded setup for Europa
require('nvim-treesitter.parsers').get_parser_configs().europa = {
  install_info = {
    url = '/home/geoff/projects/europa/europa-core/src/main/tree-sitter-europa',
    files = { 'src/parser.c' },
  },
  filetype = 'europa',
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'europa' },
  highlight = {
    enable = true,
  },
}
