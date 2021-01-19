------ HELPERS -------
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local execute = vim.api.nvim_command

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = " "

---- PLUGINS -------

-- install packer if not install on computer
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

require('plugins')

---- ***************** -----
---- ** COLOR SCHEME ** ----
---- ***************** -----

g['gruvbox_italic']= 1
g['gruvbox_italicize_strings'] = 1
g['gruvbox_invert_indent_guides'] = 1

--- *************** ---
--- *** OPTIONS *** ---
--- *************** ---

-- General
cmd 'syntax enable'
cmd 'colorscheme gruvbox'                              -- Put your favorite colorscheme here

opt('o', 'termguicolors', true)                       -- True color support
opt('o', 'mouse', 'a')                                -- Listen to mouse events
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('o', 'clipboard', 'unnamedplus')

-- UI settings
opt('w', 'list', true)                                -- Show some invisible characters (tabs...)
opt('w', 'number', true)                              -- Print line number
opt('w', 'relativenumber', true)                      -- Relative line numbers
opt('w', 'cursorline', true)                          -- show cursarline
opt('w', 'signcolumn', 'number')

-- Spacing Behaviour
local indent = 2
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('w', 'wrap', false)                               -- Disable line wrap
opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'scrolloff', 2 )                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'backspace', 'indent,eol,start')

-- File/BackFile behaviour
opt('o', 'swapfile', false)
opt('o', 'backup', false)
opt('o', 'writebackup', false)
opt('b', 'undofile', true)
opt('o', 'confirm', true) -- prompt to save before destructive actions

if fn.isdirectory(vim.o.undodir) == 0 then fn.mkdir(vim.o.undodir, "p") end

---- KeyMaps -----

map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly

-- === Search shorcuts === "
map('', '<leader>h', '<cmd>%s///<left><left>')
map('n', '<leader>/', '<cmd>noh<CR>')

-- fzf shortcuts
map('n', '<leader>p', '<cmd>Files<CR>')
map('n', '<leader>b', '<cmd>Buffers<CR>')

-- pane navigation ---
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- temp highligh of yanked text disabled in visual mode

-- NERD tree --
map('n', '<leader>n', '<cmd>NERDTreeToggle<CR>')
g['NERDTreeMinimalUI'] = 1
g['NERDTreeShowHidden'] = 1

--- Hide certain files and directories from NERDTree
g['NERDTreeIgnore'] = {'^\\.DS_Store$', '^tags$', '\\.git$[[dir]]', '\\.sass-cache$'}

-- Treesitter config
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "html", "css" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
}
