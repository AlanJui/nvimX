-----------------------------------------------------------
-- Initial environments for Neovim
-- 設定 my-nvim 作業時，所需之「全域常數」。
-----------------------------------------------------------
DEBUG = false
MY_VIM = 'nvim'
HOME = os.getenv('HOME')

CONFIG_DIR = HOME .. '/.config/' .. MY_VIM
RUNTIME_DIR = HOME .. '/.local/share/' .. MY_VIM

PACKAGE_ROOT = RUNTIME_DIR .. '/site/pack'
INSTALL_PATH = PACKAGE_ROOT .. '/packer/start/packer.nvim'
COMPILE_PATH = CONFIG_DIR .. '/plugin/packer_compiled.lua'

INSTALLED = false
if vim.fn.empty(vim.fn.glob(INSTALL_PATH)) == 0 then
	INSTALLED = true
end

LSP_SERVERS = {
	'sumneko_lua',
	'texlab',
	'pyright',
	'emmet_ls',
	'html',
	'jsonls',
	'rust_analyzer',
	'tsserver',
}

-----------------------------------------------------------
-- Global Functions
-- 載入 my-nvim 作業時，所需之各種 Global Functions 。
-----------------------------------------------------------
require("globals")

---------------------------------------------------------------
-- Install Plugin Manager & Plugins / Load Plugins
-- 當 packer.nvim 尚未安裝，可自動執行下載及安裝作業；
-- 若 packer.nvim 已安裝，則執行擴充套件 (plugins) 的載入作業。
---------------------------------------------------------------
-- configure packer.nvim
require("load-plugins")

-- configure Neovim to automatically run :PackerCompile whenever
-- plugin-list.lua is updated with an autocommand:
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-----------------------------------------------------------
-- configuration of plugins
-- 載入各擴充套件(plugins) 的設定
-----------------------------------------------------------
require("plugins-rc/nvim-treesitter")
require("lsp/luasnip")
require("lsp") -- integrate with auto cmp
require("lsp/null-langserver")
require("plugins-rc/autopairs")
-- code runner
require("plugins-rc/yabs")

-----------------------------------------------------------
-- Configurations for Neovim
-- 設定 Neovim 的 Options
-----------------------------------------------------------
-- Must have options of Neovim when under development of init.lua
-- 在開發階段，init.lua 務必須有的 Neovim 設定
require('essential')

-- General options of Neovim
-- 在開發完成後，Neovim 應有的設定
require('options')

-- User's specific options of Neovim
-- 使用者有個人應用需求的特殊設定
require('settings')

-----------------------------------------------------------
-- Color Themes
-- Neovim 畫面的色彩設定
-----------------------------------------------------------
require('color-themes')

-----------------------------------------------------------
-- Key bindings
-- 操作時的按鍵設定
-----------------------------------------------------------
-- Load Shortcut Key
-- 「快捷鍵」設定
require('keymaps')

-- Load Which-key
-- 提供【選單】式的指令操作
require('plugins-rc.which-key')

-----------------------------------------------------------
-- Experiments
-- 實驗用的臨時設定
-----------------------------------------------------------

-- For folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Say hello
local function blah()
    print("init.lua is loaded!\n")
end

blah()
