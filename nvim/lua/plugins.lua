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
  use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'norcalli/nvim-colorizer.lua'
  use 'mhartington/formatter.nvim'

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

  -- ## Nvim LSP client and copmletion ## --
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'L3MON4D3/LuaSnip'

  -- ## Better tmux/nvim interactions ## --
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'tmux-plugins/vim-tmux'

  -- ## Preview Markdown files on Browser ## --
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}

  -- ## Smooth scrolling ## --
end)

 -- Removed plugins that may later be useful
  -- use 'justinmk/vim-sneak'
  -- use 'romgrk/barbar.nvim' 
