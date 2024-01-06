------------------------------------------------
-- Neovim global options
------------------------------------------------
require('config.options')
require("globals")
local nvim_config = _G.GetConfig()
vim.g.loaded_python2_provider = 0
vim.g.loaded_python3_provider = 1
vim.g.python3_host_prog = nvim_config["python"]["nvim_binary"]
vim.g.node_host_prog = nvim_config["nodejs"]["node_host_prog"]
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Load plugins
require("config.lazy")

-- Short cut keymaps
require('config.keymaps')

------------------------------------------------
-- Debug Tools
-- 除錯用工具
------------------------------------------------
-- require("myTest")
