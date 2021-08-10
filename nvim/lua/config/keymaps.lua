local map_key = vim.api.nvim_set_keymap

-- Remap space as leader key
map_key('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
map_key('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map_key('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

--Add leader shortcuts
local options = { noremap = true, silent = true }
map_key('n', '<leader><Space>', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], options)
map_key('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], options)
map_key('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], options)
map_key('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], options)
map_key('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], options)
map_key('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], options)
map_key('n', '<leader>gr', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], options)
map_key('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], options)
map_key('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], options)

-- Nvim Tree Keymaps
map_key('n', '<leader>n', [[<cmd>NvimTreeToggle<CR>]], options)

-- Better pane navigation
map_key('n', '<C-h>', [[<C-w>h]], options)
map_key('n', '<C-j>', [[<C-w>j]], options)
map_key('n', '<C-k>', [[<C-w>k]], options)
map_key('n', '<C-l>', [[<C-w>l]], options)

-- Y yank until the end of line
map_key('n', 'Y', 'y$', { noremap = true })

-- Trouble keybindings
map_key("n", "<leader>xx", "<cmd>Trouble<cr>", options)
map_key("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", options)
map_key("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", options)
map_key("n", "<leader>xl", "<cmd>Trouble loclist<cr>", options)
map_key("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", options)
map_key("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", options)
