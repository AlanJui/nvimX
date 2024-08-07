------------------------------------------------
-- Neovim global options
------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ","
require("config.options")

vim.g.loaded_python2_provider = 0
vim.g.loaded_python3_provider = 1
vim.g.python3_host_prog = require("utils.python").get_python_path()

vim.g.node_host_prog = os.getenv("HOME") .. "/n/bin/neovim-node-host"
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Load plugins
require("config.lazy")

-- Short cut keymaps
require("config.keymaps")

------------------------------------------------
-- Debug Tools
-- 除錯用工具
------------------------------------------------
-- require("myTest")

-- local util = require("utils.table")
-- local key_maps = require("config.default_mappings").bufferline
-- util.print_table(key_maps)

require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false, -- disables setting the background color.
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" }, -- Change the style of comments
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·" }

-- 設定字體為 JetBrains Mono 12
-- vim.opt.guifont = "JetBrains Mono:h12"
-- if vim.fn.has("gui_running") == 1 then
--   vim.opt.guifont = "LXGW WenKai Mono:h18"
-- end
-- vim.opt.guifont = "LXGW WenKai Mono:h18"
vim.opt.guifont = "Microsoft JhengHei:h18"

------------------------------------------------
-- UFO Folding
-- 除錯用工具
------------------------------------------------
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

-- 支援 WSL 的剪貼簿
-- vim.g.clipboard = {
--   name = "win32yank-wsl",
--   copy = {
--     ["+"] = "win32yank.exe -i --crlf",
--     ["*"] = "win32yank.exe -i --crlf",
--   },
--   paste = {
--     ["+"] = "win32yank.exe -o --lf",
--     ["*"] = "win32yank.exe -o --lf",
--   },
--   cache_enabled = 0,
-- }
