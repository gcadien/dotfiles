print("options.lua")
local cmd = vim.cmd
  cmd('augroup lsp')
  cmd('au!')
  cmd("autocmd FileType java lua require('lsp.java').start_jdt()")
cmd('augroup end')
