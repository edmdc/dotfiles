local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  -- ## Tpope Classics ## --
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  -- ## Syntax Highlight & Formatter ## --
  use 'nvim-treesitter/nvim-treesitter'
	use 'norcalli/nvim-colorizer.lua'
  use 'mhartington/formatter.nvim'
  use 'jparise/vim-graphql'

  -- ## Explore files ## --
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- ## UI/UX Plugins ## --
  use 'morhetz/gruvbox'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'psliwka/vim-smoothie'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use { 
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'folke/lsp-colors.nvim'

  -- ## Nvim LSP client, copmletion, and diagnostics ## --
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'L3MON4D3/LuaSnip'
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons"
  }

  -- ## Better tmux/nvim interactions ## --
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'tmux-plugins/vim-tmux'

  -- ## Preview Markdown files on Browser ## --
  -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
end)

 -- Removed plugins that may later be useful
  -- use 'justinmk/vim-sneak'
  -- use 'romgrk/barbar.nvim' 
