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

  -- ## Syntax Highlight & text objects ## --
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
	use 'norcalli/nvim-colorizer.lua'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- ## Coloscheme, Statusline, BufferBar ## --
  use 'morhetz/gruvbox'
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require 'spaceline' end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- ## Built-in LSP client & Autocompletion/Snippet plugin ## --
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'L3MON4D3/LuaSnip'

  -- ## Better tmux/nvim interactions ## --
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'tmux-plugins/vim-tmux'

  -- ## Preview Markdown files on Browser ## --
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}

  -- ## Smooth scrolling ## --
  use 'psliwka/vim-smoothie'
end)

  -- use 'sainnhe/gruvbox-material'
  -- use 'jparise/vim-graphql'
  -- ## Autocompletion ## --
  -- use {'neoclide/coc.nvim', branch = 'release'}
  -- use {'rodrigore/coc-tailwind-intellisense', run = 'npm install'}
  -- use 'thaerkh/vim-indentguides'
  -- use 'romgrk/barbar.nvim' 
  -- use 'justinmk/vim-sneak'
  -- use {'preservim/nerdtree', requires = {'ryanoasis/vim-devicons', 'vwxyutarooo/nerdtree-devicons-syntax'}}
  -- use 'mhinz/vim-signify'

  -- -- ## Automatic tags management ## --
  -- use 'ludovicchabant/vim-gutentags'

