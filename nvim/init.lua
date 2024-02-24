vim.g.mapleader = " " 

require("config.lazy")
require("config.options")
require("config.lsp")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "europa", "kotlin", 'zig', },
	callback = function()
    print("FileType callback " .. vim.bo.filetype)
    require("lsp.client").start(vim.bo.filetype)
	end,
})
vim.api.nvim_create_autocmd("User", {
    --pattern = "VeryLazy",
    callback = function()
        require("config.autocmds")
        require("config.keymap")
    end,
})
