-----------------------------------------------------------
-- Python environment
-----------------------------------------------------------
PYENV_ROOT_PATH = HOME .. '/.pyenv/versions/'
PYTHON_VERSION = '3.10.0'
PYTHON_VENV = 'venv-3.10.0'
PYENV_GLOBAL_PATH = PYENV_ROOT_PATH .. '/' .. PYTHON_VERSION .. '/bin/python'
PYTHON_BINARY = PYENV_ROOT_PATH .. PYTHON_VERSION .. '/envs/' .. PYTHON_VENV .. '/bin/python'

-----------------------------------------------------------
-- Neovim global options
-----------------------------------------------------------
-- vim.g.python3_host_prog = PYTHON_BINARY
vim.g.python3_host_prog = '/home/alanjui/.pyenv/versions/3.10.6/bin/python3.10'
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-----------------------------------------------------------
-- Essential configuration on development init.lua
-----------------------------------------------------------
local set = vim.opt -- global options
-- local cmd = vim.cmd -- execute Vim commands
-- local exec = vim.api.nvim_exec -- execute Vimscript
-- local fn    = vim.fn            -- call Vim functions
-- local g     = vim.g             -- global variables
-- local b     = vim.bo            -- buffer-scoped options
-- local w     = vim.wo            -- windows-scoped options

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
vim.o.timeoutlen=500

vim.opt.encoding = 'UTF-8'
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.guifont = 'DroidSansMono Nerd Font 18'

-- Display line number on side bar
vim.opt.numberwidth = 4
vim.wo.number = true
vim.wo.relativenumber = true
-- Disable line wrap
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.wo.wrap = false
-- Tabs
vim.opt.tabstop = 8 -- spaces per tab
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
vim.opt.expandtab = false -- don't expand tabs into spaces
vim.opt.smarttab = true -- <tab>/<BS> indent/dedent in leading whitespace
vim.opt.expandtab = true

vim.cmd([[
autocmd FileType lua setlocal expandtab shiftwidth=4 tabstop=4 smartindent
autocmd BufEnter *.lua set autoindent expandtab shiftwidth=4 tabstop=4
]])

set.clipboard = set.clipboard + 'unnamedplus' --copy & paste
-- Display tabs, newline control characters
set.list = false -- show whitespace
set.listchars = {
    nbsp = '⦸', -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends = '»', -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes = '«', -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab = '▷─', -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
    trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
    space = ' ',
}
set.fillchars = {
    diff = '∙', -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    eob = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    fold = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    vert = ' ', -- remove ugly vertical lines on window division
}

-- Disable line wrap
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.wo.wrap = false -- don't automatically wrap on load

set.showmatch = true -- show the matching part of the pair for [] {} and ()
set.cursorline = true -- highlight current line
set.number = true -- show line numbers
set.relativenumber = true -- show relative line number
