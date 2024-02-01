------------------------------------------------
-- Neovim global options
------------------------------------------------
vim.g.mapleader = " "
require("config.options")

vim.g.loaded_python2_provider = 0
vim.g.loaded_python3_provider = 1
vim.g.python3_host_prog = require("utils.python").get_python_path()

vim.g.node_host_prog = os.getenv("HOME") .. "/n/bin/neovim-node-host"
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Load Keymaps
-- require("utils").load_mappings()

-- Load plugins
require("config.lazy")

-- Short cut keymaps
require("config.keymaps")

------------------------------------------------
-- Debug Tools
-- 除錯用工具
------------------------------------------------
-- require("myTest")

-- require("utils").load_mappings("general")
-- vim.inspect(key_maps)
-- _G.PrintTable(key_maps)
-- local util = require("utils.table")
-- local key_maps = require("config.default_mappings").bufferline
-- util.print_table(key_maps)
-- local mappings = require("config.default_mappings")
-- local mappings = require("utils").load_config().mappings
-- require("utils.table").print_table(mappings)
