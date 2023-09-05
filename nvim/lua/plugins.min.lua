vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'gruvbox-community/gruvbox'
  use {'wbthomason/packer.nvim', opt = true}
  use {'nvim-treesitter/nvim-treesitter'}
  use {
    'nvim-orgmode/orgmode', config = function()
        require('orgmode').setup{}
    end
  }
  end)

