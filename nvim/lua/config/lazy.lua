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

require("lazy").setup({
  import = "plugins",  -- auto-import all plugin files in this directory
}, {
  defaults = {
    lazy = true,  -- Enable lazy loading by default
  },
  ui = {
    border = "rounded",
  },
})


