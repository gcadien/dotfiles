vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  use {'mjlbach/neovim-ui'}
  use {'wbthomason/packer.nvim', opt = true}
  use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
	use {'junegunn/fzf.vim'}
  use {'andrejlevkovitch/vim-lua-format'}
  use {'Shougo/denite.nvim',  run = ':UpdateRemotePlugins' }
  use 'nvim-lua/completion-nvim'
  use 'masukomi/vim-markdown-folding'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'brandoncc/telescope-harpoon.nvim'
  --use 'jkramer/vim-checkbox'
  --use 'nvim-lua/plenary.nvim'
  use 'plasticboy/vim-markdown'
  use 'godlygeek/tabular'
  use 'neovim/nvim-lspconfig'
  use 'gruvbox-community/gruvbox'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use {
    '~/projects/vim-note',
    rocks = {'http', 'lunajson'}
  }
  use '~/projects/telescope-spiral.nvim'
  use_rocks 'penlight'
end)

