-----------------------------------------------------------------
-- Plugin Manager: install plugins
-- $ nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
-----------------------------------------------------------------
local package_root = PACKAGE_ROOT
local compile_path = COMPILE_PATH
local install_path = INSTALL_PATH

-----------------------------------------------------------------
-- 確認 packer.nvim 套件已安裝，然後再「載入」及「更新」。
-----------------------------------------------------------------

-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- 確認套件 packer.nvim 已被安裝，且已被載入 nvim
local ok, packer = pcall(require, "packer")
if not ok then
	return
end

packer.init({
	package_root = package_root,
	compile_path = compile_path,
	plugin_package = "packer",
	display = { open_fn = require("packer.util").float },
	max_jobs = 10,
})

-- 確認 packer.nvim 已能運作後，處理 nvim 套件安裝作業
local ok1, plugins = pcall(require, "plugins")
if not ok1 then
	return
end

packer.startup(function(use)
	plugins.load(use)

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		packer.sync()
	end
end)

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])
