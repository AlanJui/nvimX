-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
-- Disable swap file
opt.swapfile = false
opt.backup = false
opt.writebackup = false
-- opt.foldmethod = "marker"
-- opt.foldmethod = "indent"
opt.foldcolumn = "1"
opt.foldlevel = 99 --- Using ufo provider need a large value
opt.foldlevelstart = 99 --- Expand all folds by default
opt.foldenable = true --- Use spaces instead of tabs
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
