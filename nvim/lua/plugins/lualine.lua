print("lualine")
local M = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy",
  opts = function() 
    print("lualine opts")
    return {
      options = {
        theme = "gruvbox"
      }
    }
  end
}

return M

