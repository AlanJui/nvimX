----------------------------------------------------------------
-- Plugin Manager: install plugins
-- $ nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
-----------------------------------------------------------------
local nvim_config = _G.GetConfig()
local package_root = nvim_config["package_root"]
local compile_path = nvim_config["compile_path"]
local install_path = nvim_config["install_path"]

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

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
-- vim.cmd([[
-- augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
-- augroup end
-- ]])

-----------------------------------------------------------------
-- 確認擴充套件 packer.nvim 已安裝，以便執行「初始設定作業」。
-----------------------------------------------------------------
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

-----------------------------------------------------------------
-- 透過 packer 執行「擴充套件載入作業」
-----------------------------------------------------------------
local use = require("packer").use
return packer.startup(function()
  -----------------------------------------------------------
  -- Essential plugins
  -----------------------------------------------------------
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  -- lua functions that many plugins use
  use("nvim-lua/plenary.nvim")
  -- Tools to migrating init.vim to init.lua
  -- use("norcalli/nvim_utils")
  -- To make Neovim's fold look modern and keep high performance.
  use({
    "kevinhwang91/nvim-ufo",
    requires = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
  })
  -----------------------------------------------------------
  -- Completion: for auto-completion/suggestion/snippets
  -----------------------------------------------------------
  -- A completion plugin for neovim coded in Lua.
  use({
    -- Completion framework
    "hrsh7th/nvim-cmp",
    requires = {
      -- LSP completion source
      "hrsh7th/cmp-nvim-lsp",
      -- Useful completion sources
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
  use({
    "L3MON4D3/LuaSnip",
    -- follow latest release
    tag = "v1.*",
    -- install jsregexp (optional!:)
    run = "make install_jsregexp",
  })
  -- Snippets collection for a set of different programming languages for faster development
  use("rafamadriz/friendly-snippets")
  -----------------------------------------------------------
  -- LSP/LspInstaller: configurations for the Nvim LSP client
  -----------------------------------------------------------
  -- A collection of common configurations for Neovim's built-in language
  -- server client
  use({ "neovim/nvim-lspconfig" })
  -- companion plugin for nvim-lspconfig that allows you to seamlessly
  -- install LSP servers locally
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })
  -- bridges gap b/w mason & null-ls
  use("jay-babu/mason-null-ls.nvim")
  -- helps users keep up-to-date with their tools and to make certain
  -- they have a consistent environment.
  -- use({ "williamboman/nvim-lsp-installer" })
  -- use({ "WhoIsSethDaniel/mason-tool-installer.nvim" })
  -- formatting & linting
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim", -- stylua-nvim is a mini Lua code formatter
      "ckipp01/stylua-nvim",
    },
  })
  -- LSP plugin based on Neovim build-in LSP with highly a performant UI
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })
  -- vscode-like pictograms for neovim lsp completion items Topics
  use({ "onsails/lspkind-nvim" })
  --
  -- All in one LSP plugin (include auto-complete)
  --
  -- use({
  --   "VonHeikemen/lsp-zero.nvim",
  --   branch = "v1.x",
  --   requires = {
  --     -- LSP Support
  --     { "neovim/nvim-lspconfig" }, -- Required
  --     { "williamboman/mason.nvim" }, -- Optional
  --     { "williamboman/mason-lspconfig.nvim" }, -- Optional
  --
  --     -- Autocompletion
  --     { "hrsh7th/nvim-cmp" }, -- Required
  --     { "hrsh7th/cmp-nvim-lsp" }, -- Required
  --     { "hrsh7th/cmp-buffer" }, -- Optional
  --     { "hrsh7th/cmp-path" }, -- Optional
  --     { "saadparwaiz1/cmp_luasnip" }, -- Optional
  --     { "hrsh7th/cmp-nvim-lua" }, -- Optional
  --
  --     -- Snippets
  --     { "L3MON4D3/LuaSnip" }, -- Required
  --     { "rafamadriz/friendly-snippets" }, -- Optional
  --
  --     -- Optional
  --     { "simrat39/rust-tools.nvim" },
  --   },
  -- })
  -----------------------------------------------------------
  -- AI Tooles
  -----------------------------------------------------------
  -- ChatGPT
  use({
    "jackMort/ChatGPT.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  })
  -- AI code auto-complete
  use({ "github/copilot.vim" })
  use({ "hrsh7th/cmp-copilot" })
  -- Copilot Lua
  -- use({ "zbirenbaum/copilot.lua" })
  -- use({
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- })
  -- use({
  --   "zbirenbaum/copilot-cmp",
  --   after = { "copilot.lua" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- })
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
  -- colorscheme for neovim written in lua specially made for roshnvim
  -----------------------------------------------------------
  use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
  use("bluz71/vim-moonfly-colors")
  use("shaeinst/roshnivim-cs")
  use("mhartington/oceanic-next")
  use("folke/tokyonight.nvim")
  -----------------------------------------------------------
  -- User Interface
  -----------------------------------------------------------
  -- Quick switch between files
  use("ThePrimeagen/harpoon")
  -- maximizes and restores current window
  use("szw/vim-maximizer")
  -- tmux & split window navigation
  use("christoomey/vim-tmux-navigator")
  -- Add indentation guides even on blank lines
  use({ "lukas-reineke/indent-blankline.nvim" })
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
  -- Fuzzy files finder
  -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  })
  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    requires = {
      --------------------------------------------------------
      -- Telescope Extensions
      --------------------------------------------------------
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-live-grep-raw.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "ahmedkhalf/project.nvim",
      "cljoly/telescope-repo.nvim",
      "stevearc/aerial.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "kkharji/sqlite.lua",
      "aaronhallaert/advanced-git-search.nvim",
      "benfowler/telescope-luasnip.nvim",
      "olacin/telescope-cc.nvim",
      "tsakirist/telescope-lazy.nvim",
      {
        "ecthelionvi/NeoComposer.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        enabled = false,
        opts = {},
      },
    },
  })
  --------------------------------------------------------
  -- Enhance UI for Neovim
  --------------------------------------------------------
  -- vs-code like icons
  use("nvim-tree/nvim-web-devicons")
  -- File/Flolders explorer:nvim-tree
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        "s1n7ax/nvim-window-picker",
        tag = "v1.*",
        config = function()
          require("window-picker").setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
            other_win_hl_color = "#e35e4f",
          })
        end,
      },
    },
    config = function()
      require("plugins-rc.neo-tree")
    end,
  })
  -- Screen Navigation
  use("folke/which-key.nvim")
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
    -- "TimUntersberger/neogit",
    "NeogitOrg/neogit",
    requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
  })
  -- for creating gist
  -- Personal Access Token: ~/.gist-vim
  -- token XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  use({ "mattn/vim-gist", requires = "mattn/webapi-vim" })
  -----------------------------------------------------------
  -- Editting Tools
  -----------------------------------------------------------
  -- replace with register contents using motion (gr + motion)
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  })
  -- Toggle comments in Neovim
  use({ "numToStr/Comment.nvim" })
  -- A Neovim plugin for setting the commentstring option based on the cursor
  -- location in the file. The location is checked via treesitter queries.
  use("JoosepAlviste/nvim-ts-context-commentstring")
  -- Causes all trailing whitespace characters to be highlighted
  use({ "cappyzawa/trim.nvim" })
  -- Splitting/Joining blocks of code
  use({
    "Wansmer/treesj",
    requires = { "nvim-treesitter" },
    config = function()
      require("treesj").setup({--[[ your config ]]
      })
      -- For use default preset and it work with dot
      vim.keymap.set("n", "<leader>m", require("treesj").toggle)
      -- For extending default preset with `recursive = true`, but this doesn't work with dot
      vim.keymap.set("n", "<leader>M", function()
        require("treesj").toggle({ split = { recursive = true } })
      end)
    end,
  })
  -- Multiple cursor editting
  use({ "mg979/vim-visual-multi" })
  -- visualizes undo history and makes it easier to browse and switch between different undo branches
  use({ "mbbill/undotree" })
  -- Auto close parentheses and repeat by dot dot dot ...
  use({ "windwp/nvim-autopairs" })
  -- Use treesitter to autoclose and autorename html tag
  use({ "windwp/nvim-ts-autotag" })
  -- Auto change html tags
  use({ "AndrewRadev/tagalong.vim" })
  -- A high-performance color highlighter for Neovim
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })
  -- Source Code Outline
  use({
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup()
    end,
  })
  -----------------------------------------------------------
  -- Coding Tools
  -----------------------------------------------------------
  -- A pretty list for showing diagnostics, references, telescope results, quickfix and
  -- location lists to help you solve all the trouble your code is causing.
  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  })
  -- Yet Another Build System
  use({ "pianocomposer321/yabs.nvim", requires = { "nvim-lua/plenary.nvim" } })
  -- terminal
  use({ "pianocomposer321/consolation.nvim" })
  use({ "akinsho/toggleterm.nvim", tag = "*" })
  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  })
  use({ "nvim-neotest/neotest-plenary" })
  use({ "nvim-neotest/neotest-python" })
  -----------------------------------------------------------
  -- DAP
  -----------------------------------------------------------
  use({ "mfussenegger/nvim-dap" })
  -- bridges mason.nvim with the nvim-dap plugin - making it
  -- easier to use both plugins together.
  use({ "jay-babu/mason-nvim-dap.nvim" })
  --
  -- Language specific exensions
  --
  -- DAP for Python
  use({ "mfussenegger/nvim-dap-python" })
  -- DAP for Lua work in Neovim
  use({ "jbyuki/one-small-step-for-vimkind" })
  -- DAP for Node.js (nvim-dap adapter for vscode-js-debug)
  use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
  --
  -- DAP UI Extensions
  --
  -- UI for nvim-dap
  -- Install icons for dap-ui: https://github.com/ChristianChiarulli/neovim-codicons
  use({ "folke/neodev.nvim" })
  -- Reset nvim-dap-ui to a specific commit
  use({
    "rcarriga/nvim-dap-ui",
    -- tag = 'v3.6.4',
    requires = {
      "mfussenegger/nvim-dap",
    },
  })
  -- Inlines the values for variables as virtual text using treesitter.
  use({ "theHamsta/nvim-dap-virtual-text" })
  -- -- Integration for nvim-dap with telescope.nvim
  use({ "nvim-telescope/telescope-dap.nvim" })
  -- UI integration for nvim-dat with fzf
  use({ "ibhagwan/fzf-lua" })
  -- nvim-cmp source for using DAP completions inside the REPL.
  use({ "rcarriga/cmp-dap" })
  -----------------------------------------------------------
  -- Utility
  -----------------------------------------------------------
  -- File explorer: vifm
  use("vifm/vifm.vim")
  -- Floater Terminal
  use({ "voldikss/vim-floaterm" })
  -- Live server
  use({ "turbio/bracey.vim", run = "npm install --prefix server" })
  -- Open URI with your favorite browser from your most favorite editor
  use({ "tyru/open-browser.vim" })
  -- PlantUML
  use({ "weirongxu/plantuml-previewer.vim" })
  -- PlantUML syntax highlighting
  use({ "aklt/plantuml-syntax" })
  -- provides support to mermaid syntax files (e.g. *.mmd, *.mermaid)
  use({ "mracos/mermaid.vim" })
  -- Markdown support Mermaid
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })
  -- highlight your todo comments in different styles
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({})
      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Previous todo comment" })

      -- You can also specify a list of valid jump keywords
      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
      end, { desc = "Next error/warning todo comment" })
    end,
  })
  -----------------------------------------------------------
  -- LaTeX
  -----------------------------------------------------------
  -- Vimtex
  use({ "lervag/vimtex" })
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
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
