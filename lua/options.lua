-- options.lua
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
set.hlsearch = true -- highlighted search results
set.ignorecase = true -- ignore case sensetive while searching
set.smartcase = true
set.scrolloff = 1 -- when scrolling, keep cursor 1 lines away from screen border
set.sidescrolloff = 2 -- keep 30 columns visible left and right of the cursor at all times
set.backspace = 'indent,start,eol' -- make backspace behave like normal again
set.mouse = 'a' -- turn on mouse interaction
set.updatetime = 500 -- CursorHold interval
set.autoindent = true -- maintain indent of current line
set.shiftround = true
set.splitbelow = true -- open horizontal splits below current window
set.splitright = true -- open vertical splits to the right of the current window
set.laststatus = 2 -- always show status line
--set.colorcolumn = "79"        -- vertical word limit line

set.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
set.inccommand = 'split' -- live preview of :s results
-- set.shell = 'zsh' -- shell to use for `!`, `:!`, `system()` etc.

-- patterns to ignore during file-navigation
set.wildignore = set.wildignore + '*.o,*.rej,*.so'
-- faster scrolling
set.lazyredraw = true
--Save undo history
vim.cmd([[set undofile]])

-- Disable swap file
vim.opt.swapfile = false
vim.opt.writebackup = false

-- make buffer modifiable
vim.opt.modifiable = true

-- remove whitespace on save
-- cmd([[au BufWritePre * :%s/\s\+$//e]])
-- don't auto commenting new lines
-- cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
-- completion options
-- set.completeopt = 'menuone,noselect,noinsert'

-- highlight on yank
exec(
    [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500, on_visual=true}
  augroup end
]]   ,
    false
)

-- jump to the last position when reopening a file
cmd([[
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
]])

-- -- 4 spaces for selected filetypes
-- cmd([[ autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 smartindent ]])
-- cmd([[ autocmd FileType python set foldmethod=indent foldlevel=99 ]])
-- cmd([[ autocmd FileType lua setlocal shiftwidth=4 tabstop=4 ]])
-- -- 2 spaces for selected filetypes
-- cmd([[ autocmd FileType xml, html, xhtml, css, scss, javascript, dart setlocal shiftwidth=2 tabstop=2 ]])
-- -- json
-- cmd([[ au BufEnter *.json set ai expandtab shiftwidth=2 tabstop=2 sta fo=croql ]])

-- Reformat indent line
-- gg=G
-- vim.cmd([[
-- command! -range=% Format :<line1>,<line2>s/^\s*/&&
-- ]])
