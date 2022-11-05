local M = {}

M.load = function(use)
	-----------------------------------------------------------
	-- Essential plugins
	-----------------------------------------------------------
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- Tools to migrating init.vim to init.lua
	use("norcalli/nvim_utils")
	-----------------------------------------------------------
	-- LSP/LspInstaller: configurations for the Nvim LSP client
	-----------------------------------------------------------
	-- companion plugin for nvim-lspconfig that allows you to seamlessly
	-- install LSP servers locally
	use({ "williamboman/nvim-lsp-installer" })
	-- A collection of common configurations for Neovim's built-in language
	-- server client
	use({ "neovim/nvim-lspconfig" })
	-- Null-LS: for formatters and linters
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim", -- stylua-nvim is a mini Lua code formatter
			"ckipp01/stylua-nvim",
		},
	})
	-- automatically highlighting other uses of the current word under the cursor
	use({ "RRethy/vim-illuminate" })
	-----------------------------------------------------------
	-- Completion: for auto-completion/suggestion/snippets
	-----------------------------------------------------------
	-- A completion plugin for neovim coded in Lua.
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			-- nvim-cmp source for neovim builtin LSP client
			"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for nvim lua
			"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for buffer words
			"hrsh7th/cmp-buffer", -- nvim-cmp source for filesystem paths
			"hrsh7th/cmp-path", -- nvim-cmp source for math calculation
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-cmdline",
			-- LuaSnip completion source for nvim-cmp
			"saadparwaiz1/cmp_luasnip",
		},
	})
	-- Snippet Engine for Neovim written in Lua.
	use({
		"L3MON4D3/LuaSnip",
        tag = "v<CurrentMajor>.*",
        after = 'nvim-cmp',
		requires = {
			-- Snippets collection for a set of different programming languages for faster development
			"rafamadriz/friendly-snippets",
		},
	})
	-----------------------------------------------------------
	-- Treesitter: for better syntax
	-----------------------------------------------------------
	-- Nvim Treesitter configurations and abstraction layer
	use("nvim-treesitter/nvim-treesitter")
	-- use({
	--     'nvim-treesitter/nvim-treesitter',
	--     run = ':TSUpdate',
	--     -- config = [[ require('plugins.treesitter') ]]
	--     config = [[ require('plugins.nvim-treesitter') ]],
	-- })
	-- Additional textobjects for treesitter
	use("nvim-treesitter/nvim-treesitter-textobjects")
	-----------------------------------------------------------
	-- User Interface
	-----------------------------------------------------------
	-- Add indentation guides even on blank lines
	use({ "lukas-reineke/indent-blankline.nvim" })
	-- Status Line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({ "arkav/lualine-lsp-progress" })
	use({
		"kdheepak/tabline.nvim",
		require = { "hoob3rt/lualine.nvim", "kyazdani42/nvim-web-devicons" },
	})
	-- Utility functions for getting diagnostic status and progress messages
	-- from LSP servers, for use in the Neovim statusline
	use({ "nvim-lua/lsp-status.nvim" })
	-- Support LSP CodeAction
	use({ "kosayoda/nvim-lightbulb" })
	-- vscode-like pictograms for neovim lsp completion items Topics
	-- use({
	--     'onsails/lspkind-nvim',
	--     config = [[ require('plugins.lspkind') ]],
	-- })
	-- LSP plugin based on Neovim build-in LSP with highly a performant UI
	-- use {
	--     'glepnir/lspsaga.nvim',
	--     requires = { 'neovim/nvim-lspconfig' },
	--     config = [[ require('plugins.lspsaga-nvim') ]]
	-- }
	-- Icons
	use({ "kyazdani42/nvim-web-devicons" })
	-- use({
	--     'yamatsum/nvim-nonicons',
	--     requires = { 'kyazdani42/nvim-web-devicons' }
	-- )}
	-- Fuzzy files finder
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-raw.nvim",
		},
	})
	-- File/Flolders explorer:nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})
	-- Screen Navigation
	use("folke/which-key.nvim")
	-----------------------------------------------------------
	-- colorscheme for neovim written in lua specially made for roshnvim
	-----------------------------------------------------------
	use("shaeinst/roshnivim-cs")
	use("mhartington/oceanic-next")
	use("bluz71/vim-moonfly-colors")
	use("bluz71/vim-nightfly-guicolors")
	use("folke/tokyonight.nvim")
	-----------------------------------------------------------
	-- Git Tools
	-----------------------------------------------------------
	-- Git commands in nvim
	use("tpope/vim-fugitive")
	-- Fugitive-companion to interact with github
	use("tpope/vim-rhubarb")
	-- Add git related info in the signs columns and popups
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
	-- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
	use({
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
	})
	-- for creating gist
	-- Personal Access Token: ~/.gist-vim
	-- token XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	use({ "mattn/vim-gist", requires = "mattn/webapi-vim" })
	-----------------------------------------------------------
	-- Editting Tools
	-----------------------------------------------------------
	-- surroundings: parentheses, brackets, quotes, XML tags, and more
	use({ "tpope/vim-surround", requires = { "tpope/vim-repeat" } })
	-- Toggle comments in Neovim
	use({ "tpope/vim-commentary" })
	-- Causes all trailing whitespace characters to be highlighted
	use({ "ntpeters/vim-better-whitespace" })
	-- Auto close parentheses and repeat by dot dot dot ...
	use({ "windwp/nvim-autopairs" })
	-- use({
	--     'windwp/nvim-autopairs',
	--     wants = 'nvim-treesitter',
	--     module = {
	--         'nvim-autopairs.completion.cmp',
	--         'nvim-autopairs',
	--     },
	-- })
	-- Multiple cursor editting
	use({ "mg979/vim-visual-multi" })
	-- visualizes undo history and makes it easier to browse and switch between different undo branches
	use({ "mbbill/undotree" })
	---------------------------------------------------------------
	-- HTML
	---------------------------------------------------------------
	-- provides support for expanding abbreviations similar to emmet
	use({ "mattn/emmet-vim" })
	-- Auto tag
	use({ "windwp/nvim-ts-autotag" })
	-- Auto close tag
	-- use({ 'alvan/vim-closetag', })
	-- Auto change html tags
	use({ "AndrewRadev/tagalong.vim" })
	---------------------------------------------------------------
	-- Python
	---------------------------------------------------------------
	-- ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax
	-- checking and semantic errors) in NeooVim while you edit your text files,
	-- and acts as a Vim Language Server Protocol client.
	-- use({
	--     'dense-analysis/ale',
	--     config = vim.cmd([[
	--         runtime ./lua/plugins/ale.rc.vim
	--     ]])
	-- })
	--  Modifies Vim’s indentation behavior to comply with PEP8 and my aesthetic preferences.
	use("Vimjas/vim-python-pep8-indent")

	-- Python: provides text objects and motions for Python classes, methods,
	-- functions and doc strings
	use("jeetsukumaran/vim-pythonsense")
	-----------------------------------------------------------
	-- Programming
	-----------------------------------------------------------
	-- Yet Another Build System
	use({ "pianocomposer321/yabs.nvim", requires = { "nvim-lua/plenary.nvim" } })
	-- terminal
	use({ "pianocomposer321/consolation.nvim" })
	use({ "akinsho/toggleterm.nvim", tag = "v1.*" })
	-----------------------------------------------------------
	-- DAP
	-----------------------------------------------------------
	use({ "mfussenegger/nvim-dap" })
	-- nvim-dap’s functionality for managing various debuggers.
	-- use({ 'Pocco81/DAPInstall.nvim' })
	-- Manage debuggers provided by nvim-dap.
	use({ "Pocco81/dap-buddy.nvim" })
	-----------------------------------------------------------
	-- UI Extensions
	-----------------------------------------------------------
	-- Experimental UI for nvim-dap
	use({ "rcarriga/nvim-dap-ui" })
	-- Inlines the values for variables as virtual text using treesitter.
	use({ "theHamsta/nvim-dap-virtual-text" })
	-- Integration for nvim-dap with telescope.nvim
	use({ "nvim-telescope/telescope-dap.nvim" })
	-- UI integration for nvim-dat with fzf
	use({ "ibhagwan/fzf-lua" })
	-- nvim-cmp source for using DAP completions inside the REPL.
	use({ "rcarriga/cmp-dap" })
	-----------------------------------------------------------
	-- Language specific exensions
	-----------------------------------------------------------
	-- DAP adapter for Python
	use({ "mfussenegger/nvim-dap-python" })
	-- DAP adapter for the Neovim lua language
	use({ "jbyuki/one-small-step-for-vimkind" })
	-----------------------------------------------------------
	-- Polyglot language extensions
	-----------------------------------------------------------
	-- -- A Vim wrapper for running tests on different granularities.
	-- use({ 'vim-test/vim-test' })
	-- -- Test runner building upon vim-test with nvim-dap support.
	-- use({
	--     'rcarriga/vim-ultest',
	--     requires = { 'vim-test/vim-test' },
	--     run = ':UpdateRemotePlugins',
	-- })
	-----------------------------------------------------------
	-- Utility
	-----------------------------------------------------------
	-- Floater Terminal
	use("voldikss/vim-floaterm")
	-- highlight your todo comments in different styles
	-- use({
	-- 	'folke/todo-comments.nvim',
	-- 	requires = 'nvim-lua/plenary.nvim',
	-- 	config = function()
	-- 	    require('todo-comments').setup({
	--              -- configuration comes here
	--              -- or leave it empty to use the default setting
	-- 	    })
	-- 	end,
	-- })
	-- Live server
	use({ "turbio/bracey.vim", run = "npm install --prefix server" })
	-- Markdown preview
	use({ "instant-markdown/vim-instant-markdown" })
	-- PlantUML
	use({ "weirongxu/plantuml-previewer.vim" })
	-- PlantUML syntax highlighting
	use("aklt/plantuml-syntax")
	-- Open URI with your favorite browser from your most favorite editor
	use("tyru/open-browser.vim")
	-----------------------------------------------------------
	-- LaTeX
	-----------------------------------------------------------
	-- Vimtex
	use("lervag/vimtex")
	-- Texlab configuration
	use({
		"f3fora/nvim-texlabconfig",
		config = function()
			require("texlabconfig").setup({
				cache_active = true,
				cache_filetypes = { "tex", "bib" },
				cache_root = vim.fn.stdpath("cache"),
				reverse_search_edit_cmd = "edit",
				file_permission_mode = 438,
			})
		end,
		ft = { "tex", "bib" },
		cmd = { "TexlabInverseSearch" },
	})
end

return M
