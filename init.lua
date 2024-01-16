------------------------------------------------
-- Neovim global options
------------------------------------------------
require("config.options")
require("globals")

local home_dir = os.getenv "HOME"
local PYTHON_VERSION = "3.12.1"

vim.g.loaded_python2_provider = 0
vim.g.loaded_python3_provider = 1
vim.g.python3_host_prog = home_dir .. "/.pyenv/versions/" .. PYTHON_VERSION .. "/bin/python"

vim.g.node_host_prog = home_dir .. "/n/bin/neovim-node-host"
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Load plugins
require("config.lazy")

-- Short cut keymaps
require("config.keymaps")

------------------------------------------------
-- Debug Tools
-- 除錯用工具
------------------------------------------------
-- require("myTest")
