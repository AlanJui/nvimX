-----------------------------------------------------------
-- Plugin Manager: install plugins
-- $ nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
-----------------------------------------------------------

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path
	})
end

-- Load plugins
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'tomasr/molokai'

		-- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
		use({
			'TimUntersberger/neogit',
			requires = {
				'nvim-lua/plenary.nvim',
				'sindrets/diffview.nvim',
			},
			config = function() require('rc.neogit') end,
		})
	-- Fuzzy files finder
	use({
		'nvim-telescope/telescope.nvim',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-telescope/telescope-live-grep-raw.nvim' },
		},
		config = function() require('rc.telescope-nvim') end,
	})
	
	-- Floatting terminal
	use 'voldikss/vim-floaterm'

	-- Toggle comments in Neovim
	use { 'tpope/vim-commentary' }

	-- Screen Navigation
	use { 'folke/which-key.nvim' }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)



