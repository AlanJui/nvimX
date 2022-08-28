--------------------------------------------------------------------
-- keymap.lua
--------------------------------------------------------------------
if DEBUG then
	print('<< DEBUG: Loading keymaps.lua >>')
end

-- local keymap = require('utils.set_keymap')
local keymap = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

vim.g.maplocalleader = ","

keymap('i', 'jj', '<Esc>', opts)

-- Ctrl-s: to save
keymap('n',  '<c-s>', ':w<CR>', {})
keymap('i',  '<c-s>', '<Esc>:w<CR>a', {})

--------------------------------------------------------------------
-- Line editting
--------------------------------------------------------------------
-- Editting on Insert Mode
keymap('i', '<M-,>', '<Esc>lli,', opts)
keymap('i', '<M-.>', '<Esc>lli.', opts)
keymap('i', '<M-:>', '<Esc>lli:', opts)
keymap('i', '<M-,><M-,>', '<Esc>A,', opts)
keymap('i', '<M-.><M-.>', '<Esc>A.', opts)
keymap('i', '<M-:><M-:>', '<Esc>A:', opts)
-- Blank whole line
-- keymap('n', '<M-l>', '0d$', opts)
-- keymap('n', '<M-p>', 'pdd', opts)
-- Indent / Unident a line
keymap('n', '<M->>', 'V><Esc>', opts)
keymap('n', '<M-<>', 'V<<Esc>', opts)
-- Remove Line
keymap('i', '<C-CR>',   '<Esc>A<Esc>jddO', opts)

-- Insert line
keymap('i', '<M-n>',    '<Esc>o', opts)
keymap('i', '<M-i>',    '<Esc>o<Esc>jddkA', opts)
keymap('n', '<M-i>',    '^i<Tab>', opts)
-- Insert text in HTML Tags
keymap('i', '<M-lt>',    '<CR><Esc>O', opts)

-- Editting in line
keymap('n', 'I', '^d$i', opts)
keymap('n', 'H', '0', opts)
keymap('n', 'L', '$', opts)
keymap('n', 'X', 'd$', opts)
keymap('n', 'Y', 'y$', opts)
-- Insert a item in table
-- keymap('i', '<M-t>', '<ESC>A,<ESC>hi<CR><ESC>O', opts)

-- Move line
keymap('n', '<S-Down>', ':m .+1<CR>', opts)
keymap('n', '<S-Up>', ':m .-2<CR>', opts)
keymap('i', '<S-Down>', '<Esc>:m .+1<CR>', opts)
keymap('i', '<S-Up>', '<Esc>:m .-2<CR>', opts)
keymap('v', '<S-Down>', ":move '>+1<CR>gv-gv", opts)
keymap('v', '<S-Up>', ":move '<-2<CR>gv-gv", opts)

-- Indent/Unident
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

--------------------------------------------------------------------
-- Windows navigation
--------------------------------------------------------------------
-- Split window
keymap('n', 'sp', ':split<CR>', opts)
keymap('n', 'vs', ':vsplit<CR>', opts)
keymap('n', '<C-w>-', ':split<CR>', opts)
keymap('n', '<C-w>|', ':vsplit<CR>', opts)

-- Move focus on window
keymap('n', '<C-Up>',    '<cmd>wincmd k<CR>', opts)
keymap('n', '<C-Down>',  '<cmd>wincmd j<CR>', opts)
keymap('n', '<C-Left>',  '<cmd>wincmd h<CR>', opts)
keymap('n', '<C-Right>', '<cmd>wincmd l<CR>', opts)

keymap('n', '<ESC>k', '<cmd>wincmd k<CR>', opts)
keymap('n', '<ESC>j', '<cmd>wincmd j<CR>', opts)
keymap('n', '<ESC>h', '<cmd>wincmd h<CR>', opts)
keymap('n', '<ESC>l', '<cmd>wincmd l<CR>', opts)

-- Window Resize
keymap('n', '<M-Up>',    '<cmd>wincmd -<CR>', opts)
keymap('n', '<M-Down>',  '<cmd>wincmd +<CR>', opts)
keymap('n', '<M-Left>',  '<cmd>wincmd <<CR>', opts)
keymap('n', '<M-Right>', '<cmd>wincmd ><CR>', opts)

-- Window Zoom In/Out
keymap('n', '<C-w>i', ':tabnew %<CR>', opts)
keymap('n', '<C-w>o', ':tabclose<CR>', opts)

--------------------------------------------------------------------
-- Buffers
--------------------------------------------------------------------
-- Tab operations
keymap('n', 'gt', '<cmd>bn<CR>', opts)
keymap('n', 'gT', '<cmd>bp<CR>', opts)
-- keymap('n', 'tn', ':tabnew<CR>', { noremap = true })
-- keymap('n', 'tk', ':tabnext<CR>', { noremap = true })
-- keymap('n', 'tj', ':tabprev<CR>', { noremap = true })
-- keymap('n', 'to', ':tabo<CR>', { noremap = true })

-- Tab navigation
-- keymap('n', 'gT', ':TablineBufferPrevious<CR>', opts)
-- keymap('n', 'gt', ':TablineBufferNext<CR>', opts)

-- Buffers
-- keymap('n', '<Tab>', '<cmd>bn<CR>', opts)
-- keymap('n', '<S-Tab>', '<cmd>bp<CR>', opts)

--------------------------------------------------------------------
-- Clear highlighting on escale in normal mode.
--------------------------------------------------------------------
-- keymap('n', '<Esc>', ':noh<CR><Esc>', opts)

--------------------------------------------------------------------
-- Terminal mode
--------------------------------------------------------------------
keymap('t', '<Esc>', '<C-\\><C-n>', opts)

--------------------------------------------------------------
-- Nonbuild-in commands
--------------------------------------------------------------
-- Comment
keymap('n', '<C-_>', ':CommentToggle<CR>',      opts)
keymap('v', '<C-_>', ":'<,'>CommentToggle<CR>", opts)
keymap('n', '<C-_>', ':Commentary<CR>', opts)
keymap('v', '<C-_>', ":'<,'>Commentary<CR>", opts)

