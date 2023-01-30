-----------------------------------------------------------
-- Initial global constants
-- 設定所需使用之「全域常數」。
-----------------------------------------------------------
local nvim_config = _G.GetConfig()

-----------------------------------------------------------
-- Neovim global options
-----------------------------------------------------------
-- vim.g.python3_host_prog = nvim_config["python"]["binary"]
vim.g.python3_host_prog = nvim_config["python"]["nvim_binary"]
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-----------------------------------------------------------
-- Essential configuration on development init.lua
-----------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = ";"
vim.o.timeoutlen = 500

vim.opt.encoding = "UTF-8"
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmatch = true -- show the matching part of the pair for [] {} and ()
vim.opt.mouse = "a"
vim.guifont = "DroidSansMono Nerd Font 18"

-- Display line number on side bar
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line number
vim.opt.numberwidth = 4
-- vim.wo.number = true
-- vim.wo.relativenumber = true

-- Tab stops
-- By default(softtabstop=0, noexpandtab), a tab keypress will give you a \t character.
-- And a backspace keypress will remove 1 character.
--
-- If you set expandtab, then a tab keypress will give you tabstop spaces.
-- A backspace keypress will remove 1 character.
--
-- If you set softtabstop, then a tab keypress will give you softabstop spaces.
-- A backspace keypress will remove softabstop columns of whitespace.
--
-- vim.opt.softtabstop = 0
vim.opt.softtabstop = 4
vim.opt.tabstop = 4 -- spaces per tab
vim.opt.shiftwidth = 4 -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
vim.opt.expandtab = false -- don't expand tabs into spaces
vim.opt.smarttab = true -- <tab>/<BS> indent/dedent in leading whitespace
vim.opt.autoindent = true -- maintain indent of current line
vim.opt.smartindent = true

-- Tabs
-- vim.bo.expandtab = true
-- vim.bo.shiftwidth = 2
-- vim.bo.softtabstop = 2
-- vim.cmd([[
-- autocmd FileType lua setlocal expandtab shiftwidth=4 tabstop=4 smartindent
-- autocmd BufEnter *.lua set autoindent expandtab shiftwidth=4 tabstop=4
-- ]])

-- Display none-displayed characters
-- tab        = '→',
vim.opt.list = true -- show whitespace
vim.opt.listchars = {
	nbsp = "⦸", -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
	extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
	precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
	tab = "▷─", -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
	trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
	space = " ",
}
vim.opt.fillchars = {
	diff = "∙", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
	eob = " ", -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
	fold = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
	vert = " ", -- remove ugly vertical lines on window division
}

-- Disable line wrap
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.wrap = false
-- vim.wo.wrap = false
