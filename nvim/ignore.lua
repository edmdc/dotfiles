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

g.mapleader = ' '

---- PLUGINS -------

-- install packer if not install on computer
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

require('plugins')

-- -- deoplete
-- g['deoplete#enable_at_startup'] = 1
-- fn['deoplete#custom#option']('ignore_case', false)
-- fn['deoplete#custom#option']('max_list', 10)

-- buffer/tabline nav --
map('', '<C-b>', '<cmd>BufferPick<CR>')

map('n', '<C-w>ts', '<cmd>split<bar>terminal<CR>')
map('n', '<C-w>tv', '<cmd>vsplit<bar>terminal<CR>')

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
opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options (for deoplete)
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
-- opt('o', 'showcmd', false)
opt('o', 'showmode', false)
opt('o', 'confirm', true) -- prompt to save before destructive actions

if fn.isdirectory(vim.o.undodir) == 0 then fn.mkdir(vim.o.undodir, "p") end

---- Keys -----
map('', '<C-R>', '<cmd>source ~/.config/nvim/init.lua<CR>')

map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly

-- === Search shorcuts === "
map('', '<leader>h', ':%s///g<left><left>')
map('n', '<leader>/', '<cmd>noh<CR>')

-- fzf shortcuts
map('n', '<leader>p', '<cmd>Files<CR>')
map('n', '<leader>b', '<cmd>Buffers<CR>')

-- pane navigation ---
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

-- COC settings --

vim.api.nvim_exec([[
" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" *** LOOK HERE FOR <CR> BUG *** "

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>R  :<C-u>CocRestart<cr>
" Show commands.
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
]], false)
-- opt('o', 'updatetime', 300)
-- -- <Tab> to navigate the completion menu
-- map('i', '<C-Space>', '<cmd>coc.refresh()')
-- map('i', '<cr>', 'pumvisible() ? coc#_select_confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"', {expr = true, silent = true})

-- map('n', 'gd', '<Plug>(coc-definition)', {silent = true})
-- map('n', 'gy', '<Plug>(coc-type-definition)', {silent = true})
-- map('n', 'gi', '<Plug>(coc-implementation)', {silent = true})
-- map('n',  'gr', '<Plug>(coc-references)', {silent = true})
