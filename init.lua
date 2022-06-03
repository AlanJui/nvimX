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
if DEBUG then
	-- 正處「除錯」作業階段時，僅只載入除錯時所需的
	-- 擴充套件(plugins) 設定。
	require('lsp.lsp-debug')
	_G.load_config()
elseif INSTALLED then
	-- 非「除錯」作業；且 packer.nvim 已安裝時，
	-- 則：開始載入各擴充套件（plugins）的設定；
	-- 否則：略過擴充套件設定的載入。

	-- Neovim kernel
	require('plugins-rc.nvim-treesitter')
	require('lsp.luasnip')
	-- lsp
    require("lsp") -- integrate with auto cmp
	require('lsp.null-langserver')
	-- User Interface
	require('plugins-rc.nvim-web-devicons')
	require('plugins-rc.indent-blankline')
	-- status line
	require('plugins-rc.lualine-material')
    require('plugins-rc.tabline')
    -- files management
    require('plugins-rc.telescope-nvim')
	require('plugins-rc.nvim-tree')
	-- editting tools
	require('plugins-rc.autopairs')
	require('plugins-rc.undotree')
	vim.cmd([[ runtime ./lua/plugins-rc/vim-better-whitespace.rc.vim ]])
	vim.cmd([[runtime ./lua/plugins-rc/emmet-vim.rc.vim]])
	vim.cmd([[runtime ./lua/plugins-rc/vim-closetag.rc.vim]])
	vim.cmd([[runtime ./lua/plugins-rc/tagalong-vim.rc.vim]])
	-- programming
	require('plugins-rc.yabs')
	-- debug
	require('plugins-rc.ultest')
	require('debug')
    -- versional control
	require('plugins-rc.neogit')
	require('plugins-rc.gitsigns')
	vim.cmd([[ runtime ./lua/plugins-rc/vim-signify.rc.vim]])
	-- Utilities
    require('plugins-rc.toggleterm')
	vim.cmd([[ runtime ./lua/plugins-rc/bracey.rc.vim]])
	vim.cmd([[ runtime ./lua/plugins-rc/vim-instant-markdown.rc.vim ]])
	vim.cmd([[ runtime ./lua/plugins-rc/plantuml-previewer.rc.vim ]])
	vim.cmd([[ runtime ./lua/plugins-rc/vimtex.rc.vim ]])
end


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
