vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use 'nvim-treesitter/nvim-treesitter'
  use {'junegunn/fzf', run = ':fzf#install()'}
  use 'junegunn/fzf.vim'
  -- use 'ojroques/nvim-lspfuzzy'
  use 'morhetz/gruvbox'
  use {
          'glepnir/galaxyline.nvim',
          branch = 'main',
          config = function() require 'spaceline' end,
          requires = {'kyazdani42/nvim-web-devicons', opt = true}
      }

  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-commentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'

  use 'psliwka/vim-smoothie'
  use 'justinmk/vim-sneak'
  use 'preservim/nerdtree'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'tmux-plugins/vim-tmux'
  use 'thaerkh/vim-indentguides'
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
end)
