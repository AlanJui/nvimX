local M = {}

M.load = function(use)
	-----------------------------------------------------------
	-- Essential plugins
	-----------------------------------------------------------
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- lua functions that many plugins use
	use("nvim-lua/plenary.nvim")
	-----------------------------------------------------------
	-- colorscheme for neovim written in lua specially made for roshnvim
	-----------------------------------------------------------
	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	use("bluz71/vim-moonfly-colors")
	use("shaeinst/roshnivim-cs")
	use("mhartington/oceanic-next")
	use("folke/tokyonight.nvim")
	-----------------------------------------------------------
	-- LSP/LspInstaller: configurations for the Nvim LSP client
	-----------------------------------------------------------
	-- companion plugin for nvim-lspconfig that allows you to seamlessly
	-- install LSP servers locally
	-- use({ "williamboman/nvim-lsp-installer" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	-- A collection of common configurations for Neovim's built-in language
	-- server client
	use({ "neovim/nvim-lspconfig" })
	-- formatting & linting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim", -- stylua-nvim is a mini Lua code formatter
			"ckipp01/stylua-nvim",
		},
	})
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls
	-- automatically highlighting other uses of the current word under the cursor
	use({ "RRethy/vim-illuminate" })
	-- Support LSP CodeAction
	use({ "kosayoda/nvim-lightbulb" })
	-- LSP plugin based on Neovim build-in LSP with highly a performant UI
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = { "neovim/nvim-lspconfig" },
	})
	-- vscode-like pictograms for neovim lsp completion items Topics
	use({ "onsails/lspkind-nvim" })
	-- additional functionality for typescript server
	-- (e.g. rename file & update imports)
	use({ "jose-elias-alvarez/typescript.nvim" })

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
	-- tag = "v<CurrentMajor>.*",
	use({ "L3MON4D3/LuaSnip", tag = "v1.1.*" })
	-- Snippets collection for a set of different programming languages for faster development
	use("rafamadriz/friendly-snippets")
	-----------------------------------------------------------
	-- Treesitter: for better syntax
	-----------------------------------------------------------
	-- Nvim Treesitter configurations and abstraction layer
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({
				with_sync = true,
			})
			ts_update()
		end,
	})
	-----------------------------------------------------------
	-- User Interface
	-----------------------------------------------------------
	-- Toggle Terminal
	use({ "akinsho/toggleterm.nvim", tag = "*" })
	-- Floater Terminal
	use("voldikss/vim-floaterm")
	-- Status Line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"kdheepak/tabline.nvim",
		require = { "hoob3rt/lualine.nvim", "kyazdani42/nvim-web-devicons" },
	})
	use({ "arkav/lualine-lsp-progress" })
	-- Utility functions for getting diagnostic status and progress messages
	-- from LSP servers, for use in the Neovim statusline
	use({ "nvim-lua/lsp-status.nvim" })
	-- maximizes and restores current window
	use("szw/vim-maximizer")
	-- tmux & split window navigation
	use("christoomey/vim-tmux-navigator")
	-- Fuzzy files finder
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-raw.nvim",
		},
	})
	-- Icons
	use("nvim-tree/nvim-web-devicons")
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
	-- Editting Tools
	-----------------------------------------------------------
	-- visualizes undo history and makes it easier to browse and switch between different undo branches
	use({ "mbbill/undotree" })
	-- surroundings: parentheses, brackets, quotes, XML tags, and more
	use({ "tpope/vim-surround", requires = { "tpope/vim-repeat" } })
	-- Toggle comments in Neovim
	-- use({ "tpope/vim-commentary" })
	use({ "numToStr/Comment.nvim" })
	-- A Neovim plugin for setting the commentstring option based on the cursor
	-- location in the file. The location is checked via treesitter queries.
	use("JoosepAlviste/nvim-ts-context-commentstring")
	-- Causes all trailing whitespace characters to be highlighted
	use({ "cappyzawa/trim.nvim" })
	-- Multiple cursor editting
	use({ "mg979/vim-visual-multi" })
	-- Auto close parentheses and repeat by dot dot dot ...
	use({ "windwp/nvim-autopairs" })
	-- Use treesitter to autoclose and autorename html tag
	use({ "windwp/nvim-ts-autotag" })
	-----------------------------------------------------------
	-- Git Tools
	-----------------------------------------------------------
	-- Add git related info in the signs columns and popups
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
	-- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
	use({
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
	})
end

return M
