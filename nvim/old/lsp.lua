print("lsp_config2")
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

--local map = function(type, key, value)
--	vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
--end
--
--local custom_attach = function(client)
--	print("LSP started.");
--	require'completion'.on_attach(client)
--	require'diagnostic'.on_attach(client)
--
--	map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
--	map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
--	map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
--	map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
--	map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
--	map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
--	map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
--	map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
--	map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
--	map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
--	map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
--	map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
--	map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
--	map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
--	map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
--	map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
--end
--
--require'lspconfig'.sumneko_lua.setup{
--	on_attach=custom_attach,
--	settings = {
--		Lua = {
--      cmd = {"/usr/bin/lua-language-server"},
--			runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
--			completion = { keywordSnippet = "Disable", },
--			diagnostics = { enable = true, globals = {
--				"vim", "describe", "it", "before_each", "after_each" },
--			},
--			workspace = {
--				library = {
--					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
--					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
--				}
--			}
--		}
--	}
--}

vim.lsp.start({
  name = "europa language server",
  cmd = {"java", "-jar", "/home/geoff/projects/europa/language-server/build/libs/language-server-1.0-SNAPSHOT-all.jar"},
  autostart = false,
  root_dir = "/home/geoff/europa",
  filetypes = { "europa" }
})
-- Uncomment to execute the extension test mentioned above.
-- local function custom_codeAction_callback(_, _, action)
-- 	print(vim.inspect(action))
-- end
--
