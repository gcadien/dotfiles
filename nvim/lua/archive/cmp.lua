return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
	},
	opts = function()
		print("cmp")
		local cmp = require("cmp")
		return {
			cmp.setup({
				mapping = {
					--    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
					--    ['<C-f>'] = cmp.mapping.scroll_docs(4),
					--    ['<C-Space>'] = cmp.mapping.complete(),
					--    ['<C-e>'] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					--["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
				},
         window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "orgmode" },
				}),
			}),
		}
	end,
}
