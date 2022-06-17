-----------------------------------------------------------
-- Plugin Manager: install plugins
-- $ nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
-----------------------------------------------------------
local package_root = PACKAGE_ROOT
local compile_path = COMPILE_PATH
local install_path = INSTALL_PATH
local packer_bootstrap

-----------------------------------------------------------------
-- 確認 packer.nvim 套件已安裝，然後再「載入」及「更新」。
-----------------------------------------------------------------

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	-- 已知 packer.nvim 套件尚未安裝之處理作業
	packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.api.nvim_command("packadd packer.nvim")
end

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

return require("packer").startup(function(use)
	if not DEBUG then
        plugins.load(use)
	else
		use("neovim/nvim-lspconfig")
        local debug_plugins = safe_require(debug-plugins)
        if not debug_plugins then
            for _, plugin in ipairs(debug_plugins) do
                use(plugin)
            end
        end
	end
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		packer.sync()
	end
end)
