local plugins_list = {
	-----------------------------------------------------------
	-- Essential plugins
	-----------------------------------------------------------
	-- Tools to migrating init.vim to init.lua
	"norcalli/nvim_utils", -- Packer can manage itself
	"nvim-treesitter/nvim-treesitter",
	"JoosepAlviste/nvim-ts-context-commentstring", -- snippets enginee
	-----------------------------------------------------------
	-- LSP
	-----------------------------------------------------------
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	"williamboman/nvim-lsp-installer",
	"neovim/nvim-lspconfig",
	-- Null-LS: for formatter and linters
	{
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"nvim-lua/plenary.nvim", -- stylua-nvim is a mini Lua code formatter
			"ckipp01/stylua-nvim",
		},
	}, -- auto completion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"saadparwaiz1/cmp_luasnip",
	-----------------------------------------------------------
	-- User Interface
	-----------------------------------------------------------
	"folke/which-key.nvim", -- Fuzzy files finder
	{
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-raw.nvim" },
		},
	}, -- File/Flolders explorer:nvim-tree
	{
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins-rc.nvim-tree")
		end,
	}, -- colorscheme for neovim written in lua specially made for roshnvim
	"folke/tokyonight.nvim",
	-----------------------------------------------------------
	-- Version Control
	-----------------------------------------------------------
	-- Git: version control
	{
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
	}, -- Add git related info in the signs columns and popups
	{ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } },
	-----------------------------------------------------------
	-- Utilitiies
	-----------------------------------------------------------
	-- terminal
	{ "akinsho/toggleterm.nvim", tag = "v1.*" }, -- Floatting terminal
}

return plugins_list
