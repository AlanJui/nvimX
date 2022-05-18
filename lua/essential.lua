-----------------------------------------------------------
-- Essential configuration on development init.lua
-----------------------------------------------------------
local exec = vim.api.nvim_exec -- execute Vimscript
local set = vim.opt -- global options
local cmd = vim.cmd -- execute Vim commands
-- local fn    = vim.fn            -- call Vim functions
-- local g     = vim.g             -- global variables
-- local b     = vim.bo            -- buffer-scoped options
-- local w     = vim.wo            -- windows-scoped options


vim.g.mapleader = ' '
vim.g.maplocalleader = ';'
vim.o.timeoutlen=500

vim.opt.encoding = 'UTF-8'
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.guifont = 'DroidSansMono Nerd Font 18'

set.clipboard = set.clipboard + 'unnamedplus' --copy & paste


-- Display line number on side bar
vim.opt.numberwidth = 4
vim.wo.number = true
vim.wo.relativenumber = true

-- Tabs
-- vim.bo.expandtab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

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

set.showmatch = true -- show the matching part of the pair for [] {} and ()
set.cursorline = true -- highlight current line
set.number = true -- show line numbers
set.relativenumber = true -- show relative line number

-- Disable line wrap
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.wo.wrap = false -- don't automatically wrap on load
