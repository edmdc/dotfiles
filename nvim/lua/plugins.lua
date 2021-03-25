vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  -- ## Syntax Highlight ## --
  use 'nvim-treesitter/nvim-treesitter'
  use 'jparise/vim-graphql'

  -- ## Fuzzy File Finder ## --
  use {'junegunn/fzf', run = ':fzf#install()'}
  use 'junegunn/fzf.vim'
  
  -- ## Autocompletion ## --
  use {'neoclide/coc.nvim', branch = 'release'}
  use {'rodrigore/coc-tailwind-intellisense', run = 'npm install'}

  -- ## Coloscheme, Statusline, BufferBar ## --
  use 'morhetz/gruvbox'
  use 'sainnhe/gruvbox-material'
  use 'kyazdani42/nvim-web-devicons'
  use {
        'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require 'spaceline' end,
      }
  use 'romgrk/barbar.nvim' 

  -- ## Tpope Classics ## --
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use 'psliwka/vim-smoothie'
  use 'justinmk/vim-sneak'
  use {'preservim/nerdtree', requires = {'ryanoasis/vim-devicons', 'vwxyutarooo/nerdtree-devicons-syntax'}}
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'tmux-plugins/vim-tmux'
  use 'thaerkh/vim-indentguides'
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = "MarkdowPreview" }
  use 'mhinz/vim-signify'
end)
