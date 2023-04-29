-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-----------------------------------------------------------
-- Debug Tools
-- 除錯用工具
-----------------------------------------------------------

----------------------------------------------------------------------------
-- configurations
----------------------------------------------------------------------------
require("globals")
local nvim_config = _G.GetConfig()

local function show_current_working_dir()
  -- Automatic change to working directory you start Neovim
  local my_working_dir = vim.fn.getcwd()
  print(string.format("current working dir = %s", my_working_dir))
  vim.api.nvim_command("cd " .. my_working_dir)
end

---@diagnostic disable-next-line: unused-function, unused-local
local function nvim_env_info() -- luacheck: ignore
  ----------------------------------------------------------------------------
  -- Neovim installed info
  ----------------------------------------------------------------------------
  print("init.lua is loaded!")
  print("Neovim RTP(Run Time Path ...)")
  ---@diagnostic disable-next-line: undefined-field
  _G.PrintTableWithIndent(vim.opt.runtimepath:get(), 4) -- luacheck: ignore
  print("====================================================================")
  print(string.format("OS = %s", nvim_config["os"]))
  print(string.format("Working Directory: %s", vim.fn.getcwd()))
  print("Configurations path: " .. nvim_config["config"])
  print("Run Time Path: " .. nvim_config["runtime"])
  print(string.format("Plugins management installed path: %s", nvim_config["install_path"]))
  print("path of all snippets")
  _G.PrintTableWithIndent(nvim_config["snippets"], 4)
  print("--------------------------------------------------------------------")
end

---@diagnostic disable-next-line: unused-function, unused-local
local function debugpy_info()
  ----------------------------------------------------------------------------
  -- Debugpy installed info
  ----------------------------------------------------------------------------
  local venv = nvim_config["python"]["venv"]
  print(string.format("$VIRTUAL_ENV = %s", venv))
  local debugpy_path = nvim_config["python"]["debugpy_path"]
  if _G.IsFileExist(debugpy_path) then
    print("Debugpy is installed in path: " .. debugpy_path)
  else
    print("Debugpy isn't installed in path: " .. debugpy_path .. "yet!")
  end
  print("--------------------------------------------------------------------")
end

---@diagnostic disable-next-line: unused-function, unused-local
local function nodejs_info() -- luacheck: ignore
  ----------------------------------------------------------------------------
  -- vscode-js-debug installed info
  ----------------------------------------------------------------------------
  print(string.format("node_path = %s", nvim_config.nodejs.node_path))
  print(string.format("vim.g.node_host_prog = %s", vim.g.node_host_prog))
  local js_debugger_path = nvim_config["nodejs"]["debugger_path"]
  if _G.IsFileExist(js_debugger_path) then
    print(string.format("nodejs.debugger_path = %s", nvim_config.nodejs.debugger_path))
  else
    print("JS Debugger isn't installed! " .. js_debugger_path .. "yet!")
  end
  print(string.format("debugger_cmd = %s", ""))
  _G.PrintTableWithIndent(nvim_config.nodejs.debugger_cmd, 4)
  print("====================================================================")
end

------------------------------------------------------------------------------
-- Test
------------------------------------------------------------------------------

-- Add local LuaRocks installation directory to package path
-- package.path = package.path .. ";~/.config/nvim/lua/rocks/?.lua"
-- package.path = package.path .. ";~/.config/nvim/lua/?.lua"
-- package.cpath = package.cpath .. ";~/.config/nvim/lua/rocks/?.so"
-- vim.cmd([[
-- luafile ~/.config/nvim/lua/my-chatgpt.lua
-- ]])

function _G.my_test_1()
  -- Set some options
  vim.o.tabstop = 4
  vim.o.shiftwidth = 4
  vim.o.expandtab = true

  -- Create a new buffer and set its contents
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Hello, world!" })

  -- Open the new buffer in a split window
  vim.api.nvim_command("split")
  vim.api.nvim_buf_set_name(buf, "hello.txt")
end

function _G.run_shell_command()
  local command = "ls -l"
  local output = vim.fn.system(command)
  print(output)
end
-- _G.run_shell_command()
-- show_current_working_dir()
-- debugpy_info()
-- nvim_env_info()
-- nodejs_info()
