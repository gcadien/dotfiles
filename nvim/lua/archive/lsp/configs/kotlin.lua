local doautocmd = vim.api.nvim_exec_autocmds

local filetypes = {
  kotlin = true,
}
local server = {
  name = "kotlin language server",
  cmd = {"kotlin-language-server"},
  root_dir = vim.fn.getcwd(),
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(client, bufnr)
    print("Kotlin on_attach")
    -- default completion suggestions
    -- triggered by using `<C-x><C-o>`
    --vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Use lsp server instead of tags (whenever possible)
    --vim.bo.tagfunc='v:lua.vim.lsp.tagfunc'

    -- declare your keybindings elsewhere
    --doautocmd('User', {pattern = 'LSPKeybindings'})
  end,
  on_init = function(client, results)
    if results.offsetEncoding then
      client.offset_encoding = results.offsetEncoding
    end

    if client.config.settings then
      client.notify('workspace/didChangeConfiguration', {
        settings = client.config.settings
      })
    end
  end
}

return {
  filetypes = filetypes,
  params = server
}
