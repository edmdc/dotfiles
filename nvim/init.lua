require 'plugins'

local map_key = vim.api.nvim_set_keymap
local map_buf_key = vim.api.nvim_buf_set_keymap

--Incremental live completion
vim.o.inccommand = 'nosplit'

-- Sesible window splits
vim.o.splitbelow = true
vim.o.splitright = true

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true
vim.o.smartindent = true
vim.o.expandtab = true

-- Change tab width for different file types
vim.api.nvim_exec(
  [[
    augroup IndentAccordingToFile
      autocmd!
      autocmd FileType css,scss,go setlocal tabstop=4 softtabstop=4 shiftwidth=4
      autocmd FileType typescript,typescriptreact,javascript,jsx,lua setlocal tabstop=2 softtabstop=2 shiftwidth=2
    augroup end
  ]],
	false
)

--Save undo history
vim.cmd [[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'number'
vim.o.showmode = false

--Set colorscheme (order is important here)
vim.g.gruvbox_italic = 1
vim.g.gruvbox_italicize_strings = 1
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_space_char = '•'
vim.g.indent_blankline_space_char_blankline = ' '

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '✚' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
--Add leader shortcuts
local options = { noremap = true, silent = true }
map_key('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], options)
map_key('n', '<leader>p', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], options)
map_key('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], options)
map_key('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], options)
map_key('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], options)
map_key('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], options)
map_key('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], options)
map_key('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], options)
map_key('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], options)

-- Better pane navigation
map_key('n', '<C-h>', [[<C-w>h]], options)
map_key('n', '<C-j>', [[<C-w>j]], options)
map_key('n', '<C-k>', [[<C-w>k]], options)
map_key('n', '<C-l>', [[<C-w>l]], options)

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  map_buf_key(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map_buf_key(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map_buf_key(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map_buf_key(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map_buf_key(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map_buf_key(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map_buf_key(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map_buf_key(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  map_buf_key(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map_buf_key(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map_buf_key(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map_buf_key(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map_buf_key(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  map_buf_key(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  map_buf_key(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map_buf_key(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map_buf_key(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map_buf_key(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable the following language servers
local servers = { 'rust_analyzer', 'pyright', 'tsserver', 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Change diagnostic symbols in gutter
local signs = { Error = "✗", Warning = "✻", Hint = "﹅", Information = "⦿" }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Example custom server
local sumneko_root_path = vim.fn.getenv("HOME").."/.local/bin/sumneko_lua" -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/bin/linux/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = { "javascript", "typescript", "tsx", "html", "css", "scss", "go" },
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Compe setup
require('compe').setup {
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = true,
    buffer = false,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = false,
  },
}

-- Utility functions for compe and luasnip
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local luasnip = require 'luasnip'

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

-- Map tab to the above tab complete functiones
map_key('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map_key('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
map_key('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
map_key('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

-- Map compe confirm and complete functions
map_key('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
map_key('i', '<c-space>', 'compe#complete()', { expr = true })

require 'colorizer'.setup {
  css = { css = true },
  scss = { css = true },
  'javascript',
	'typescriptreact',
  html = {
    mode = 'foreground';
  }
}
