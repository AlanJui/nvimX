------------------------------------------------------------------------------
-- Initial environments for Neovim
-- 初始階段
------------------------------------------------------------------------------
_G.MY_VIM = os.getenv("MY_NVIM") or "nvim"
_G.DEBUG = os.getenv("DEBUG") or false

-----------------------------------------------------------
-- Global Functions
-- 為後續作業，需先載入之「共用功能（Global Functions）」。
-----------------------------------------------------------
require("globals")

-----------------------------------------------------------
-- Essential settings for Neovim
-- 初始時需有的 Neovim 基本設定
-----------------------------------------------------------
require("essential")

------------------------------------------------------------------------------
-- Configuration supportting for VS Code
-- 與 VS Code 整合作業時，應有的環境設定
------------------------------------------------------------------------------
-- 使用以下方法，皆不能正確運作：
--   if vim.fn.exists('g:vscode') then
--   if vim.fn.exists('g:vscode') == 0 then
---@diagnostic disable-next-line: undefined-field
if vim.g.vscode ~= nil then
    -----------------------------------------------------------
    -- VSCode extension"
    -----------------------------------------------------------
    -- Load plugins
    require("packer").startup(function(use)
        use("easymotion/vim-easymotion")
        use("asvetliakov/vim-easymotion")
    end)
    -- Options
    require("options")
    -- Key bindings
    require("keymaps")

    return
end

------------------------------------------------------------------------------
-- Plugins
-- 擴充套件處理
------------------------------------------------------------------------------
-- (1) 安裝擴充套件管理軟體及載入擴充套件
-- Install Plugin Manager & Plugins
-- 確保擴充套件管理器（packer.nvim）已完成安裝；以便擴充套件能正常安裝、更新。
--  ①  若擴充套件管理器：packer.nvim 尚未安裝，執行下載及安裝作業；
--  ②  透過擴充套件管理器，執行擴充套件 (plugins) 之載入／安裝作業。
------------------------------------------------------------------------------
-- (2) 載入各擴充套件之設定
-- Setup configuration of plugins
-- 對已載入之各擴充套件，進行設定作業
------------------------------------------------------------------------------
if _G.DEBUG then
    -- (1)
    local debug_plugins = require("debug-plugins")
    require("config_debug_env").setup(debug_plugins)
    -- (2)
    require("plugins-rc")
else
    -- (1)
    require("plugins")
    -- (2)
    require("plugins-rc")
end

------------------------------------------------------------------------------
-- Configurations for Neovim
-- 設定 Neovim 的 Options
------------------------------------------------------------------------------
-- General options of Neovim
-- Neovim 執行時期，應有之預設
require("options")

-- User's specific options of Neovim
-- 使用者為個人需求，須變預設之設定
require("settings")

-----------------------------------------------------------
-- Color Themes
-- Neovim 畫面的色彩設定
-----------------------------------------------------------
require("color-themes")

-----------------------------------------------------------
-- Key bindings
-- 快捷鍵設定：操作時的按鍵設定
-----------------------------------------------------------
require("keymaps")

-----------------------------------------------------------
-- Experiments
-- 實驗用的臨時設定
-----------------------------------------------------------
require("utils/markdown")

-----------------------------------------------------------
-- code folding
-----------------------------------------------------------
vim.cmd([[
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=5
]])
-- Ref: https://www.jmaguire.tech/posts/treesitter_folding/
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-----------------------------------------------------------
-- Get configurations of DAP
-- 取得 DAP 設定結果
-----------------------------------------------------------
-- print("DAP = debugger/adapter/vscode-nodejs-dap")
-- print(require("debugger/adapter/vscode-nodejs-dap").show_config())

-----------------------------------------------------------
-- Debug Tools
-- 除錯用工具
-----------------------------------------------------------

----------------------------------------------------------------------------
-- configurations
----------------------------------------------------------------------------
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

-- show_current_working_dir()
debugpy_info()
-- nvim_env_info()
-- nodejs_info()
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
