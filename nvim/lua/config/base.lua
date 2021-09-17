-- Completion Settings
vim.o.inccommand = 'nosplit'
vim.opt.shortmess:append({c = true})

-- Gutter Settings
vim.wo.number = true
vim.wo.signcolumn = 'yes:1'

-- Sesible window splits
vim.o.splitbelow = true
vim.o.splitright = true

--Set highlight on search
vim.o.hlsearch = false

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

-- Indentation settings
vim.o.smartindent = true
vim.o.expandtab = true

-- use system clipboard for paste buffer
vim.o.clipboard = "unnamed"
vim.o.swapfile = false

--Save undo history
vim.cmd [[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250

-- Don't show vim mode in command space 
vim.o.showmode = false
vim.o.autoread = true

--Set colorscheme (order is important here)
vim.g.gruvbox_italic = 1
vim.g.gruvbox_italicize_strings = 1
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Change tab width for different file types
vim.api.nvim_exec(
  [[
    augroup IndentAccordingToFile
      autocmd!
      autocmd FileType css,scss,go,python,html setlocal tabstop=4 softtabstop=4 shiftwidth=4
      autocmd FileType typescript,typescriptreact,javascript,jsx,lua,sql setlocal tabstop=2 softtabstop=2 shiftwidth=2
    augroup end
  ]],
	false
)

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

vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
