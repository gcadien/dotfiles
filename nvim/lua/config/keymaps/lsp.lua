-- lua/config/keymaps/lsp.lua
local wk = require("which-key")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    print("LspAttach")
    local buf = ev.buf

    wk.add({
      { "<leader>l", group = "LSP", buffer = buf },

      { "gd",  vim.lsp.buf.definition,        desc = "Goto definition",      mode = "n", buffer = buf },
      { "gD",  vim.lsp.buf.declaration,       desc = "Goto declaration",     mode = "n", buffer = buf },
      { "gi",  vim.lsp.buf.implementation,    desc = "Goto implementation",  mode = "n", buffer = buf },
      { "gr",  vim.lsp.buf.references,        desc = "References",           mode = "n", buffer = buf },
      { "K",   vim.lsp.buf.hover,             desc = "Hover docs",           mode = "n", buffer = buf },

      { "<leader>lr", vim.lsp.buf.rename,         desc = "Rename",          mode = "n",       buffer = buf },
      { "<leader>la", vim.lsp.buf.code_action,    desc = "Code action",     mode = { "n","v"},buffer = buf },
      { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end,
                      desc = "Format",           mode = { "n","v" }, buffer = buf },

      { "[d",  vim.diagnostic.goto_prev,      desc = "Prev diagnostic",      mode = "n", buffer = buf },
      { "]d",  vim.diagnostic.goto_next,      desc = "Next diagnostic",      mode = "n", buffer = buf },
      { "<leader>ld", vim.diagnostic.open_float, desc = "Line diagnostics",  mode = "n", buffer = buf },
      { "<leader>lq", vim.diagnostic.setloclist,  desc = "Diagnostics → loclist", mode = "n", buffer = buf },
    })
  end,
})

