--------------------------------------------------------------------
-- keymap.lua
--------------------------------------------------------------------
if DEBUG then
  print("<< DEBUG: Loading keymaps.lua >>")
end

-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.keymap.set -- for conciseness

keymap("i", "jj", "<Esc>")

-- Ctrl-s: to save
keymap("n", "<c-s>", ":w<CR>", {})
keymap("i", "<c-s>", "<Esc>:w<CR>a", {})

--------------------------------------------------------------------
-- Line editting
--------------------------------------------------------------------
-- Editting on Insert Mode
-- keymap("i", "<M-,>", "<Right>,")
-- keymap("i", "<M-.>", "<Right>.")
-- keymap("i", "<M-:>", "<Right>:")
keymap("i", "<M-,><M-,>", "<Esc>A,")
keymap("i", "<M-.><M-.>", "<Esc>A.")
keymap("i", "<M-:><M-:>", "<Esc>A:")
-- Blank whole line
-- keymap('n', '<M-l>', '0d$')
-- keymap('n', '<M-p>', 'pdd')
-- Indent / Unident a line
keymap("n", "<M->>", "V><Esc>")
keymap("n", "<M-<>", "V<<Esc>")
-- Remove Line
keymap("i", "<C-CR>", "<Esc>A<Esc>jddO")

-- Insert line
keymap("i", "<M-o>", "<Esc>o")
keymap("i", "<M-n>", "<Esc>jO")
keymap("i", "<M-i>", "<Esc>O<Esc>jddkA")
keymap("n", "<M-i>", "O")
-- Insert text in HTML Tags
keymap("i", "<M-lt>", "<CR><Esc>O")

-- Editting in line
keymap("n", "I", "^d$i")
keymap("n", "H", "0")
keymap("n", "L", "$")
keymap("n", "X", "d$")
keymap("n", "Y", "y$")
-- Insert a item in table
-- keymap('i', '<M-t>', '<ESC>A,<ESC>hi<CR><ESC>O')

-- Move line
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("n", "<S-Down>", ":m .+1<CR>gv=gv")
keymap("n", "<S-Up>", ":m .-2<CR>gv=gv")
keymap("i", "<S-Down>", "<Esc>:m .+1<CR>")
keymap("i", "<S-Up>", "<Esc>:m .-2<CR>")
keymap("v", "<S-Down>", ":move '>+1<CR>gv=gv")
keymap("v", "<S-Up>", ":move '<-2<CR>gv=gv")

-- Indent/Unident
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

--------------------------------------------------------------------
-- Windows navigation
--------------------------------------------------------------------
-- Split window
keymap("n", "<localleader>sh", ":split<CR>")
keymap("n", "<localleader>sv", ":vsplit<CR>")
keymap("n", "<localleader>se", "<C-w>=") -- make split windows equal width & height
keymap("n", "<localleader>sx", ":close<CR>") -- close current split window

-- Move focus on window
keymap("n", "<ESC>k", "<cmd>wincmd k<CR>")
keymap("n", "<ESC>j", "<cmd>wincmd j<CR>")
keymap("n", "<ESC>h", "<cmd>wincmd h<CR>")
keymap("n", "<ESC>l", "<cmd>wincmd l<CR>")

-- keymap("n", "<C-k>", "<cmd>wincmd k<CR>")
-- keymap("n", "<C-j>", "<cmd>wincmd j<CR>")
-- keymap("n", "<C-h>", "<cmd>wincmd h<CR>")
-- keymap("n", "<C-l>", "<cmd>wincmd l<CR>")

-- keymap("n", "<S-Up>", "<cmd>wincmd k<CR>")
-- keymap("n", "<S-Down>", "<cmd>wincmd j<CR>")
-- keymap("n", "<S-Left>", "<cmd>wincmd h<CR>")
-- keymap("n", "<S-Right>", "<cmd>wincmd l<CR>")

-- Window Resize
keymap("n", "<M-Up>", "<cmd>wincmd -<CR>")
keymap("n", "<M-Down>", "<cmd>wincmd +<CR>")
keymap("n", "<M-Left>", "<cmd>wincmd <<CR>")
keymap("n", "<M-Right>", "<cmd>wincmd ><CR>")

-- Window Zoom In/Out
keymap("n", "<C-w>i", ":tabnew %<CR>")
keymap("n", "<C-w>o", ":tabclose<CR>")

-- maximizer window
keymap("n", "<localleader>sm", ":MaximizerToggle<CR>") -- close current split window

--------------------------------------------------------------------
-- Buffers
--------------------------------------------------------------------

-- Tab navigation
keymap("n", "<localleader>to", ":tabnew<CR>") -- open new tab
keymap("n", "<localleader>tx", ":tabclose<CR>") -- close current tab
keymap("n", "<localleader>tn", ":tabn<CR>") --  go to next tab
keymap("n", "<localleader>tp", ":tabp<CR>") --  go to previous tab

-- Tab operations
keymap("n", "gt", "<cmd>bn<CR>")
keymap("n", "gT", "<cmd>bp<CR>")

--------------------------------------------------------------------
-- Clear highlighting on escale in normal mode.
--------------------------------------------------------------------
keymap("n", "<localleader>nh", ":nohl<CR>")

--------------------------------------------------------------------
-- Terminal mode
--------------------------------------------------------------------
keymap("t", "<Esc>", "<C-\\><C-n>")

--------------------------------------------------------------
-- Nonbuild-in commands
--------------------------------------------------------------

-- nvim-tree
-- keymap("n", "<localleader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap("n", "<localleader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap("n", "<localleader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap("n", "<localleader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap("n", "<localleader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap("n", "<localleader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands
keymap("n", "<localleader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap("n", "<localleader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap("n", "<localleader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap("n", "<localleader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server
keymap("n", "<localleader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- 將下一行的文字「連到本行尾」
keymap("n", "J", "mzJ`z")

-- 螢幕翻頁捲動時，總是居中
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
-- 執行「搜尋」功能時，找到的文字所在行，總是放在螢幕居中位置
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
-- greatest remap ever
keymap("x", "<localleader>p", [["_dP]])
keymap("x", "<leader>p", [["_dP]])
keymap("x", "P", "viwp")

-- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<localleader>y", [["+y]])
keymap("n", "<localleader>Y", [["+Y]])

keymap({ "n", "v" }, "<localleader>d", [["_d]])

-- delete without yanking
-- Note: "_ is the `blackhole register` (ref: `:help "_` )
keymap("n", "<localleader>d", [["_d]])
keymap("v", "<localleader>d", [["_d]])
-- replace currently selected text with default register
-- without yanking it
keymap("v", "<localleader>p", [["_dP]])
-- bar
-- barfoo
-- bar
-- bar
---------------------------------------------------------
-- 禁用插件的映射
vim.g.plugin_disable_mappings = 1

-- 使用自己的映射
-- vim.api.nvim_set_keymap("n", "ys", "<Plug>Ysurround", {})

-- Copilot Keymap Testing
-- keymap("i", "<C-g>", "Accept")
-- keymap("i", "<C-]>", "Next Suggesion")
-- keymap("i", "<C-[>", "Prev Suggesion")
--- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself

---------------------------------------------------------
-- nvim.ufo Folding Tools
---------------------------------------------------------
keymap("n", "zR", require("ufo").openAllFolds)
keymap("n", "zM", require("ufo").closeAllFolds)

-- Buffer operations
keymap("n", "gt", "<cmd>bn<CR>")
keymap("n", "gT", "<cmd>bp<CR>")

keymap("n", "]b", "<cmd>bn<CR>")
keymap("n", "[b", "<cmd>bp<CR>")
