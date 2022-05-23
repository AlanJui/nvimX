local plugins_list = {
  -- 'wbthomason/packer.nvim',
  -- colorscheme for neovim written in lua specially made for roshnvim
  'tomasr/molokai',
  'folke/tokyonight.nvim',
  -----------------------------------------------------------
  -- LSP
  -----------------------------------------------------------
  -- LSP configurations
  'williamboman/nvim-lsp-installer',
  'neovim/nvim-lspconfig',
  -- Null-LS: for formatter and linters
  {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      -- stylua-nvim is a mini Lua code formatter
      'ckipp01/stylua-nvim',
    },
  },
  -- auto completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',
  -- snippets enginee
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
  -----------------------------------------------------------
  -- Programming
  -----------------------------------------------------------
  -- Yet Another Build System
  {
    'pianocomposer321/yabs.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  },
  -- terminal
  {
    "akinsho/toggleterm.nvim",
    tag = 'v1.*',
    config = function()
      require("toggleterm").setup()
    end
  },
  -----------------------------------------------------------
  -- User Interface
  -----------------------------------------------------------
  -- Nvim Treesitter configurations and abstraction layer:
  -- for better syntax
  'nvim-treesitter/nvim-treesitter',
  'JoosepAlviste/nvim-ts-context-commentstring',
  -- Indent Line
  "lukas-reineke/indent-blankline.nvim",
  -- Status Line
  {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true },
      'arkav/lualine-lsp-progress',
    },
    config = function() require('rc.lualine-material') end,
  },
  {
    'kdheepak/tabline.nvim',
    require = {
      'hoob3rt/lualine.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('tabline').setup({ enable = false })
    end,
  },
  -- Screen Navigation
  'folke/which-key.nvim',
  -- Fuzzy files finder
  {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-raw.nvim' },
    },
    config = function() require('rc/telescope-nvim') end,
  },
  -- Icons
  {
    'kyazdani42/nvim-web-devicons',
    config = function() require('rc/nvim-web-devicons') end,
  },
  -- File/Flolders explorer:nvim-tree
  {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('rc/nvim-tree') end,
  },
  -----------------------------------------------------------
  -- Editting
  -----------------------------------------------------------
  -- Toggle comments in Neovim
  'tpope/vim-commentary',
  -- Auto pairs, integrates with both cmp and treesitter
  "windwp/nvim-autopairs",
  -----------------------------------------------------------
  -- Utilitiies
  -----------------------------------------------------------
  -- Git: version control
  {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function() require('rc/neogit') end,
  },
  -- Show chage status of lines: add, remove, modified
  'mhinz/vim-signify',
  -- Run git commands from Neovim command line
  'tpope/vim-fugitive',
  -- Integrated with "GBrowse" command: help use to browse GitHub Repo
  'tpope/vim-rhubarb',
  -- Git commit browser
  'junegunn/gv.vim',
  -- Floatting terminal
  'voldikss/vim-floaterm',
  -- Live server
  {
    'turbio/bracey.vim',
    run = 'npm install --prefix server',
  },
  -- Markdown preview
  'instant-markdown/vim-instant-markdown',
  -- PlantUML
  'weirongxu/plantuml-previewer.vim',
  -- PlantUML syntax highlighting
  'aklt/plantuml-syntax',
  -- Open URI with your favorite browser from your most favorite editor
  'tyru/open-browser.vim',
  -- LaTeX
  'lervag/vimtex'
}

return plugins_list
