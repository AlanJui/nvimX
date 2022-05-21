-- (1) We configure buffer-level formatting options for Python files.
--
-- (2) We configure the compiler to python.
--
-- Note: Neovim loads both Vimscript and Lua files from
-- the run time path (:h rtp). Vimscript files are sourced
-- before Lua files.

vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.textwidth = 0
vim.bo.autoindent = true
vim.bo.smartindent = true

vim.cmd [[
	compiler python
]]
