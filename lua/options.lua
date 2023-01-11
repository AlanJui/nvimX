-- options.lua
local opt = vim.opt
local exec = vim.api.nvim_exec -- execute Vimscript
local set = vim.opt -- global options
local cmd = vim.cmd -- execute Vim commands
-- local fn    = vim.fn            -- call Vim functions
-- local g     = vim.g             -- global variables
-- local b     = vim.bo            -- buffer-scoped options
-- local w     = vim.wo            -- windows-scoped options

set.wrap = false -- don't automatically wrap on load
set.showmatch = true -- show the matching part of the pair for [] {} and ()
set.cursorline = true -- highlight current line
set.incsearch = true -- incremental search
set.hlsearch = false -- highlighted search results
set.ignorecase = true -- ignore case sensetive while searching
set.smartcase = true
set.scrolloff = 1 -- when scrolling, keep cursor 1 lines away from screen border
set.sidescrolloff = 2 -- keep 30 columns visible left and right of the cursor at all times
set.backspace = "indent,start,eol" -- make backspace behave like normal again
set.mouse = "a" -- turn on mouse interaction
set.updatetime = 500 -- CursorHold interval
set.autoindent = true -- maintain indent of current line
set.shiftround = true
set.splitbelow = true -- open horizontal splits below current window
set.splitright = true -- open vertical splits to the right of the current window
set.laststatus = 2 -- always show status line
-- set.colorcolumn = "79"        -- vertical word limit line

set.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
set.inccommand = "split" -- live preview of :s results
-- set.shell = 'zsh' -- shell to use for `!`, `:!`, `system()` etc.

-- patterns to ignore during file-navigation
set.wildignore = set.wildignore + "*.o,*.rej,*.so"
-- faster scrolling
set.lazyredraw = true
-- Save undo history
vim.cmd([[set undofile]])

-- Disable swap file
opt.swapfile = false
opt.backup = false
-- opt.writebackup = false

-- make buffer modifiable
opt.modifiable = true

-- highlight on yank
exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500, on_visual=true}
  augroup end
]],
	false
)

-- jump to the last position when reopening a file
cmd([[
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
]])

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
