-- Tabs
vim.bo.autoindent = true
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.shiftwidth = 4

vim.cmd [[
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
]]
