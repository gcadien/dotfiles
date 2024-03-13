vim.g.mapleader = " "
vim.g.maplocalleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
require("options")
--require("config.lazy")
--require("config.options")
--require("config.lsp")

-- Add files/folders here that indicate the root of a project
--local root_markers = { ".git", ".editorconfig" }
-- Change to table with settings if required
--local settings = vim.empty_dict()
--
--vim.api.nvim_create_autocmd("FileType", {
--	pattern = pattern,
--	callback = function(args)
--		vim.lsp.start({
--			name = "pyright",
--			cmd = {
--				"java",
--				"-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005",
--				"-jar",
--				"/home/geoff/projects/europa/language-server/build/libs/language-server-1.0-SNAPSHOT-all.jar",
--			},
--			root_dir = vim.fn.getcwd(),
--			settings = settings,
--		})
--	end,
--})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "europa" },
	callback = function()
		print("FileType callback " .. vim.bo.filetype)
	end,
})
--vim.api.nvim_create_autocmd("User", {
--    --pattern = "VeryLazy",
--    callback = function()
--        require("config.autocmds")
--        require("config.keymap")
--    end,
--})
