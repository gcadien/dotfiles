return {
--	{
--		"williamboman/mason.nvim",
--		lazy = false,
--		config = function()
--			require("mason").setup()
--		end,
--	},

--  {
--    "mason-org/mason.nvim",
--    config = function()
--      require("mason").setup()
--    end,
--    opts = {
--        ui = {
--            icons = {
--                package_installed = "✓",
--                package_pending = "➜",
--                package_uninstalled = "✗"
--            }
--        }
--    }
--}
 {
   "mason-org/mason.nvim",
    cmd   = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" }, -- option A
    build = ":MasonUpdate",               -- keep registries fresh
    opts  = { ui = { border = "rounded" } },
 },

 {
   "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {                               -- tell Mason which servers to install
      ensure_installed = { "lua_ls"},      -- ← registry names :contentReference[oaicite:0]{index=0}
    },
  },
--
--	--{
--	--	"williamboman/mason-lspconfig.nvim",
--	--	config = function()
--	--		require("mason-lspconfig").setup({
--	--			ensure_installed = { "lua_ls", "fennel_ls", "zls" },
--	--		})
--	--	end,
--	--},
--  --
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
   dependencies = {                       -- make sure these are loaded first
     "williamboman/mason-lspconfig.nvim",
     "Saghen/blink.cmp",                  -- we’ll borrow its capabilities helper
   },
   config = function()
      print("LSP Config")
     local capabilities = require("blink.cmp").get_lsp_capabilities()  -- helper :contentReference[oaicite:1]{index=1}
     local lsp = require("lspconfig")

     require("lspconfig.configs").europa_lsp = {
       default_config = {
         cmd = { "europa-lsp" },
         filetypes = { "europa" },
         root_dir = lsp.util.root_pattern(".git", "."),
       }
     }
     -- Default handler (covers every server unless overridden below)
     local function default_setup(server)
       lsp[server].setup { capabilities = capabilities }
     end

      local mason = require("mason-lspconfig")
      print(mason.setup_handlers)
      --print(require("mason-lspconfig))
     -- Use Mason’s list and call the handler for each one
     require("mason-lspconfig").setup({
        handlers = {
       default_setup,                                      -- generic
       lua_ls = function()                                 -- specialised Lua tweaks
         lsp.lua_ls.setup {
           capabilities = capabilities,
           settings = {
             Lua = {
               diagnostics = { globals = { "vim" } },
               workspace   = { checkThirdParty = false },
             },
           },
         }
       end,
        }
     })
      lsp.europa_lsp.setup({
        capabilities = capabilities,
        filetypes = {"europa"},
      })

   end,
 },
--{
--	"neovim/nvim-lspconfig",
--	config = function()
--    local capabilities = require("cmp_nvim_lsp").default_capabilities()
--		local lspconfig = require("lspconfig")
--    require("lspconfig.configs").europa_lsp = {
--      default_config = {
--        cmd = { "europa-lsp" },
--        filetypes = { "europa" },
--        root_dir = lspconfig.util.root_pattern(".git", "."),
--      }
--    }
--		-- TODO: Is this the best place for this
--		--vim.lsp.buf.format({ timeout_ms = 10000 })
--		lspconfig.lua_ls.setup({capabilities = capabilities})
--		lspconfig.kotlin_language_server.setup({})
--    lspconfig.openscad_lsp.setup({capabilities = capabilities})
--    lspconfig.basedpyright.setup({})
--    lspconfig.fennel_ls.setup({ capabilities = capabilities })
--    lspconfig.zls.setup({ capabilities = capabilities })
--    print(lspconfig.europa_lsp.setup)
--    lspconfig.europa_lsp.setup({})
--		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
--		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
--		vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
--		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
--	end,
--},
}
