local M = {}

M.setup = function(package_root, install_path, compile_path, plugins)
	-- ensure packer.nvim has been installed
	local function ensure_packer()
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

	-- true if packer was just installed
	local packer_bootstrap = ensure_packer()

	require("packer").init({
        package_root = package_root,
        compile_path = compile_path,
        plugin_package = "packer",
        display = { 
	    	display = { show_all_info = true },
            open_fn = require("packer.util").float 
        },
        max_jobs = 10,
		-- The default print log level. One of: "trace",
		-- "debug", "info", "warn", "error", "fatal".
		log = { level = "debug" },
		-- Remove disabled or unused plugins without
		-- prompting the user
		autoremove = false,
	})

	require("packer").startup({
		function(use)
			plugins.load(use)
		end,
	})

    return require("packer").startup(function(use)
        -- 正常時候載入點
        plugins.load(use)

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            packer.sync()
        end
    end)
end

return M
