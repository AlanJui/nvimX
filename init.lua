-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-----------------------------------------------------------
-- Neovim global options
-----------------------------------------------------------
require("globals")
local nvim_config = _G.GetConfig()
-- PYTHON VIRTUALENVS
-- python-virtualenv If you plan to use per-project virtualenvs often, you should assign one virtualenv for Neovim and hard-code the interpreter path via g:python3_host_prog so that the "pynvim" package is not required for each virtualenv.
-- Example using pyenv:
-- pyenv install 3.4.4
-- pyenv virtualenv 3.4.4 py3nvim
-- pyenv activate py3nvim
-- python3 -m pip install pynvim
-- pyenv which python  # Note the path
vim.g.loaded_python2_provider = 0
vim.g.loaded_python3_provider = 1
vim.g.python3_host_prog = nvim_config["python"]["nvim_binary"]
vim.g.node_host_prog = nvim_config["nodejs"]["node_host_prog"]
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-----------------------------------------------------------
-- Debug Tools
-- 除錯用工具
-----------------------------------------------------------
require("myTest")
