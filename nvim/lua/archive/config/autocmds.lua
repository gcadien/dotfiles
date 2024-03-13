print("autocmds")
--vim.api.nvim_create_autocmd("FileType", {
--	pattern = { "europa" },
--	callback = function()
--    print("FileType callback")
--    require("lsp.client").start("europa")
--	end,
--})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Actions',
  callback = function()
    print("LspAttach")
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    -- TODO Remove this mapping
    bufmap('n', 'cc', '<cmd>lua vim.lsp.buf.completion()<cr>')
  end})
