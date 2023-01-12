-----------------------------------------------------------
-- configuration of plugins
-- 載入各擴充套件(plugins) 的設定
-----------------------------------------------------------
-- Neovim kernel
require("plugins-rc/nvim-treesitter")

-- lsp
require("lsp")
require("plugins-rc/lspkind")

-- status line
require("plugins-rc/lualine-material")
require("plugins-rc/tabline")

-- User Interface
require("plugins-rc/nvim-web-devicons")
require("plugins-rc/indent-blankline")
require("plugins-rc/nvim-lightbulb")

-- files management
require("plugins-rc/copilot")
require("plugins-rc/telescope-nvim")
require("plugins-rc/nvim-tree")
require("plugins-rc/harpoon")

-- editting tools
require("plugins-rc/undotree")
require("plugins-rc/trim-nvim")
require("plugins-rc/comment-nvim")
require("plugins-rc/autopairs")
require("plugins-rc/nvim-ts-autotag")
vim.cmd([[runtime ./lua/plugins-rc/tagalong-vim.rc.vim]])

-- programming
require("plugins-rc/toggleterm")
require("plugins-rc/consolation-nvim")
require("plugins-rc/yabs")

-- versional control
require("plugins-rc/gitsigns")
require("plugins-rc/neogit")
require("plugins-rc/vim-gist")
-- vim.cmd([[ runtime ./lua/plugins-rc/vim-signify.rc.vim]])

-- Utilities
vim.cmd([[runtime ./lua/plugins-rc/bracey.rc.vim]])
vim.cmd([[runtime ./lua/plugins-rc/vim-instant-markdown.rc.vim]])
vim.cmd([[runtime ./lua/plugins-rc/plantuml-previewer.rc.vim]])
vim.cmd([[runtime ./lua/plugins-rc/vimtex.rc.vim]])

-- debug & unit testing
require("debugger")
require("unit-test")

-- Load Which-key
-- 提供【選單】式的指令操作
require("plugins-rc/which-key")
