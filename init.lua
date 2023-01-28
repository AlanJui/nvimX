------------------------------------------------------------------------------
-- Initial environments for Neovim
-- 初始階段
------------------------------------------------------------------------------
MY_VIM = os.getenv("MY_NVIM") or "nvim"
DEBUG = false
-- DEBUG = true

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
if DEBUG then
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
-- Debug Tools
-- 除錯用工具
-----------------------------------------------------------
local function nvim_env_info()
	print("Neovim: " .. MY_VIM)
	print("init.lua is loaded!")
	print("====================================================================")
	print("Neovim RTP(Run Time Path ...)")
	-- P(vim.api.nvim_list_runtime_paths())
	-- PrintTable(vim.opt.runtimepath:get())
	-- print(string.format("OS = %s", WhichOS()))
	_G.print_table(vim.opt.runtimepath:get())
	print(string.format("OS = %s", _G.which_os()))
	print(string.format("${workspaceFolder} = %s", vim.fn.getcwd()))
	----------------------------------------------------------------------------
	-- Debugpy installed info
	----------------------------------------------------------------------------
	local debugpy_path = os.getenv("HOME") .. "/.local/share/" .. MY_VIM .. "/mason/packages/debugpy/"
	if IsFileExist(debugpy_path) then
		print("Debugpy is installed in path: " .. debugpy_path)
	else
		print("Debugpy isn't installed yet!")
	end

	-- print(string.format('$VIRTUAL_ENV = %s', os.getenv('VIRTUAL_ENV')))
	local util = require("utils.python")
	local venv_python = util.get_python_path_in_venv()
	print(string.format("$VIRTUAL_ENV = %s", venv_python))
	print("====================================================================")
end

nvim_env_info()
-----------------------------------------------------------
-- Get configurations of DAP
-- 取得 DAP 設定結果
-----------------------------------------------------------
-- print("DAP = debugger/adapter/vscode-nodejs-dap")
-- print(require("debugger/adapter/vscode-nodejs-dap").show_config())
