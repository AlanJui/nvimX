vim.g.maplocalleader = ","
local keymap = vim.keymap.set

------------------------------------------------------------------------------
keymap("n", "<leader>.", "<cmd>Alpha<cr>", { desc = "Dashboard" })

-- better up/down
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Move Lines
keymap("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
keymap("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
keymap("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
keymap("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Resize window using <ctrl> arrow keys
-- keymap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- keymap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- buffers
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap("n", "gT", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
keymap("n", "gt", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
keymap(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

keymap({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
keymap("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- save file
keymap({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- lazy
keymap("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

keymap("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
keymap("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

keymap("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
keymap("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- stylua: ignore start

-- toggle options
-- quit
keymap("n", "<leader>bq", "<cmd>qa<cr>", { desc = "Quit All" })
keymap("n", "<leader>bQ", "<cmd>qa!<cr>", { desc = "Discard All and Quit" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  keymap("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end
keymap("t", "<esc><esc>", "<c-\\><c-n>", {desc = "Enter Normal Mode"})

-- windows
keymap("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
keymap("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
keymap("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
keymap("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
keymap("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
keymap("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

keymap("n", "<leader>wm", "<CMD>MaximizerToggle<CR>", { desc = "Max/Org Window" })
keymap("n", "<leader>wc", "<CMD>close<CR>", { desc = "Close Window" })
keymap("n", "<leader>wi", "<CMD>tabnew %<CR>", { desc = "Zoom-in Window" })
keymap("n", "<leader>wo", "<CMD>tabclose<CR>", { desc = "Zoom-out Window" })
keymap("n", "<leader>wh", "<CMD>split<CR>", { desc = "H-Split" })
keymap("n", "<leader>wv", "<CMD>vsplit<CR>", { desc = "V-Split" })
keymap("n", "<leader>w=", "<C-w>=", { desc = "Equal Width" })

-- Navigate vim panes better
keymap('n', '<c-k>', ':wincmd k<CR>')
keymap('n', '<c-j>', ':wincmd j<CR>')
keymap('n', '<c-h>', ':wincmd h<CR>')
keymap('n', '<c-l>', ':wincmd l<CR>')

-- tabs
keymap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
keymap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
keymap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
keymap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
keymap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
keymap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

--------------------------------------------------------------------
-- My maps
--------------------------------------------------------------------
keymap("i", "jj", "<Esc>")
keymap("i", "jk", "<Esc>")

--------------------------------------------------------------------
-- Windows navigation
--------------------------------------------------------------------
-- Split window
keymap("n", "<localleader>sh", ":split<CR>")
keymap("n", "<localleader>sv", ":vsplit<CR>")

-- Move focus on window
-- keymap("n", "<C-k>", "<cmd>wincmd k<CR>")
-- keymap("n", "<C-j>", "<cmd>wincmd j<CR>")
-- keymap("n", "<C-h>", "<cmd>wincmd h<CR>")
-- keymap("n", "<C-l>", "<cmd>wincmd l<CR>")

-- Window Resize
keymap("n", "<M-Up>", "<cmd>wincmd -<CR>")
keymap("n", "<M-Down>", "<cmd>wincmd +<CR>")
keymap("n", "<M-Left>", "<cmd>wincmd <<CR>")
keymap("n", "<M-Right>", "<cmd>wincmd ><CR>")

--------------------------------------------------------------------
-- Buffers
--------------------------------------------------------------------

-- Tab navigation
keymap("n", "to", ":tabnew<CR>") -- open new tab
keymap("n", "tx", ":tabclose<CR>") -- close current tab
keymap("n", "tn", ":tabn<CR>") --  go to next tab
keymap("n", "tp", ":tabp<CR>") --  go to previous tab
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--------------------------------------------------------------------
-- System Clipboard
--------------------------------------------------------------------
keymap("n", "<localleader>y", '"*y')
keymap("n", "<localleader>p", '"*p')
