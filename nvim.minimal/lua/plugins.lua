vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  --use {'mjlbach/neovim-ui'}
  --use {'jpalardy/vim-slime'}
  --use {'kassio/neoterm'}
  use {'wbthomason/packer.nvim', opt = true}
 -- use {'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
	--use {'junegunn/fzf.vim'}
  --use {'junegunn/vim-emoji'}
  use {'https://gitlab.com/gi1242/vim-emoji-ab'}
  --use {'andrejlevkovitch/vim-lua-format'}
  --use {'Shougo/denite.nvim',  run = ':UpdateRemotePlugins' }
  --use 'nvim-lua/completion-nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  --use 'masukomi/vim-markdown-folding'
  use 'sirtaj/vim-openscad'
  --use {
  --  'kyazdani42/nvim-tree.lua',
  --  requires = 'kyazdani42/nvim-web-devicons'
  --}
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  --use 'jkramer/vim-checkbox'
  --use 'nvim-lua/plenary.nvim'
  --use 'plasticboy/vim-markdown'
  --use 'godlygeek/tabular'
  use 'mfussenegger/nvim-jdtls'
  use 'neovim/nvim-lspconfig'
  use 'gruvbox-community/gruvbox'
  --  Look into configuring galaxyline later
  use {
  'glepnir/galaxyline.nvim',
    branch = 'main',
    -- your statusline
--    config = function() require'my_statusline' end,
    -- some optional icons
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  --use 'glepnir/galaxyline.nvim'
  --use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  --use 'vim-airline/vim-airline'
  --use 'vim-airline/vim-airline-themes'
  use 'vim-pandoc/vim-pandoc'
  use 'vim-pandoc/vim-pandoc-syntax'
  use 'JuliaEditorSupport/julia-vim'
  use 'kdheepak/JuliaFormatter.vim'
--  use {
--    'vim-pandoc/vim-pandoc',
--    requires = {{'vim-pandoc/vim-pandoc-syntax'}}
--  }
--  use {
--    '~/projects/spiral.nvim',
--    rocks = {'http', 'lunajson'}
--  }
  --use '~/projects/telescope-spiral.nvim'
  use_rocks 'penlight'
  use_rocks 'inspect'
end)

