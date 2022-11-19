-----------------------------------------------------------
-- Initial environments for Neovim
-- 初始階段
-----------------------------------------------------------
-- Global Functions
-- 為後續作業，需先載入之「共用功能（Global Functions）」。
require("globals")

-----------------------------------------------------------
-- Initial global constants
-- 設定所需使用之「全域常數」。
-----------------------------------------------------------
DEBUG = false
-- DEBUG = true

MY_VIM = "nvim"
OS_SYS = which_os()
HOME = os.getenv("HOME")

CONFIG_DIR = HOME .. "/.config/" .. MY_VIM
RUNTIME_DIR = HOME .. "/.local/share/" .. MY_VIM

PACKAGE_ROOT = RUNTIME_DIR .. "/site/pack"
INSTALL_PATH = PACKAGE_ROOT .. "/packer/start/packer.nvim"
COMPILE_PATH = CONFIG_DIR .. "/plugin/packer_compiled.lua"

INSTALLED = false
if vim.fn.empty(vim.fn.glob(INSTALL_PATH)) == 0 then
	INSTALLED = true
end

LSP_SERVERS = {
	"vimls",
	"sumneko_lua",
	"diagnosticls",
	"pyright",
	"emmet_ls",
	"html",
	"cssls",
	"tailwindcss",
	"stylelint_lsp",
	"eslint",
	"jsonls",
	"tsserver",
	"texlab",
}

DEBUGPY = "~/.virtualenvs/debugpy/bin/python"

-- Your own custom vscode style snippets
SNIPPETS_PATH = { CONFIG_DIR .. "/my-snippets/snippets" }

-- Essential Options
-- 初始時需有的 Neovim 基本設定
require("essential")

-----------------------------------------------------------
-- Initial RTP (Run Time Path) environment
-- 設定 RTP ，要求 Neovim 啟動時的設定作業、執行作業，不採預設。
-- 故 my-nvim 的設定檔，可置於目錄： ~/.config/my-nvim/ 運行；
-- 執行作業（Run Time）所需使用之擴充套件（Plugins）與 LSP Servers
-- 可置於目錄： ~/.local/share/my-nvim/
-----------------------------------------------------------
local function setup_rtp()
	-- 變更 stdpath('config') 預設的 rtp : ~/.config/nvim/
	vim.opt.rtp:remove(join_paths(vim.fn.stdpath("data"), "site"))
	vim.opt.rtp:remove(join_paths(vim.fn.stdpath("data"), "site", "after"))
	vim.opt.rtp:prepend(join_paths(RUNTIME_DIR, "site"))
	vim.opt.rtp:append(join_paths(RUNTIME_DIR, "site", "after"))

	-- 變更 stdpath('data') 預設的 rtp : ~/.local/share/my-nvim/
	vim.opt.rtp:remove(vim.fn.stdpath("config"))
	vim.opt.rtp:remove(join_paths(vim.fn.stdpath("config"), "after"))
	vim.opt.rtp:prepend(CONFIG_DIR)
	vim.opt.rtp:append(join_paths(CONFIG_DIR, "after"))

	-- 引用 rpt 設定 package path （即擴充擴件(plugins)的安裝路徑）
	-- 此設定需正確，指令：requitre('<PluginName>') 才能正常執行。
	vim.cmd([[let &packpath = &runtimepath]])
end

if not DEBUG then
	setup_rtp()
else
	-- 在「除錯」作業時，顯示 setup_rtp() 執行前、後， rtp 的設定內容。
	-- P(vim.api.nvim_list_runtime_paths())
	Print_table(vim.opt.runtimepath:get())
	print("-----------------------------------------------------------")

	setup_rtp()

	Print_table(vim.opt.runtimepath:get())
	print("-----------------------------------------------------------")
	-- P(vim.api.nvim_list_runtime_paths())
end

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
		-- Screen Navigation
		-- use("folke/which-key.nvim")
	end)
	-- load configurations for plugins
	-- require('plugins-rc.which-key')
	-- Must have options of Neovim when under development of init.lua
	require("essential")
	-- Key bindings
	require("keymaps")

	return
end

------------------------------------------------------------------------------
-- Install Plugin Manager & Plugins
-- 確保擴充套件管理器（packer.nvim）已完成安裝；以便擴充套件能正常安裝、更新。
-- (1) 當 packer.nvim 尚未安裝，可自動執行下載及安裝作業；
-- (2) 若 packer.nvim 已安裝，則執行擴充套件 (plugins) 的載入作業。
------------------------------------------------------------------------------
require("load-plugins")

------------------------------------------------------------------------------
-- configuration of plugins
-- 載入各擴充套件(plugins) 的設定
------------------------------------------------------------------------------
if DEBUG then
	-- 正處「除錯」作業階段時，僅只載入除錯時所需的
	-- 擴充套件(plugins) 設定。
	require("lsp.lsp-debug")
	_G.load_config()
elseif INSTALLED then
	-- 非「除錯」作業；且 packer.nvim 已安裝時，
	-- 則：開始載入各擴充套件（plugins）的設定；
	-- 否則：略過擴充套件設定的載入。
	require("setup-plugins")
end

------------------------------------------------------------------------------
-- Configurations for Neovim
-- 設定 Neovim 的 Options
------------------------------------------------------------------------------
-- General options of Neovim
-- Neovim 於完成初始設定作業後，於執行時期，應有之設定
require("options")

-- User's specific options of Neovim
-- 使用者有個人應用需求的特殊設定
require("settings")

-----------------------------------------------------------
-- Color Themes
-- Neovim 畫面的色彩設定
-----------------------------------------------------------
if not INSTALLED or DEBUG then
	print("<< Load default colorscheme >>")
	-- Use solarized8_flat color scheme when first time start my-nvim
	vim.cmd([[ colorscheme solarized8_flat ]])
else
	require("color-themes")
end

-----------------------------------------------------------
-- Key bindings
-- 操作時的按鍵設定
-----------------------------------------------------------
-- Load Shortcut Key
-- 「快捷鍵」設定
require("keymaps")

-- Load Which-key
-- 提供【選單】式的指令操作
if INSTALLED then
	require("plugins-rc.which-key")
end

-----------------------------------------------------------
-- Experiments
-- 實驗用的臨時設定
-----------------------------------------------------------

-- For folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Say hello
local function blah()
	print("init.lua is loaded!")
	print("====================================================================")
	print(string.format("OS = %s", which_os()))
	print(string.format("${workspaceFolder} = %s", vim.fn.getcwd()))
	print(string.format("DEBUGPY = %s", DEBUGPY))

	-- print(string.format('$VIRTUAL_ENV = %s', os.getenv('VIRTUAL_ENV')))
	local util = require("utils.python")
	local venv_python = util.get_python_path_in_venv()
	print(string.format("$VIRTUAL_ENV = %s", venv_python))
	print("====================================================================")
end

-- blah()
