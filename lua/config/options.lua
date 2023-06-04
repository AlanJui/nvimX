-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
-- Disable swap file
opt.swapfile = false
opt.backup = false
opt.writebackup = false
-- opt.foldmethod = "marker"
opt.foldmethod = "indent"
