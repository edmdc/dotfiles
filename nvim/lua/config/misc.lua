--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_space_char = '•'
vim.g.indent_blankline_space_char_blankline = ' '

-- Nvim Tree
vim.g.nvim_tree_auto_open = 1 
vim.g.nvim_tree_auto_close = 1

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = ' ✚' },
    change = { hl = 'GitGutterChange', text = ' ~' },
    delete = { hl = 'GitGutterDelete', text = ' _' },
    topdelete = { hl = 'GitGutterDelete', text = ' ‾' },
    changedelete = { hl = 'GitGutterChange', text = ' ~' },
  },
}

require 'colorizer'.setup {
  css = { css = true },
  scss = { css = true },
  'javascript',
	'typescriptreact',
  html = {
    mode = 'foreground';
  }
}

require 'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = {'', ''},
    section_separators = {' ', ' '},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'filename'},
    lualine_c = {
      {
        'diff',
        colored = true,
        symbols = {added = '+', modified = '~', removed = '-'}
      },
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        symbols = {error = '✘:', warn = '✻:', info = '﹅:'}
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}
