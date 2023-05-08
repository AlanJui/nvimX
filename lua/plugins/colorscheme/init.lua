-- Configure LazyVim to load gruvbox
-- 選用 Colorscheme ，須至 plugins/core.lua 變更
-- {
--   "LazyVim/LazyVim",
--   opts = {
--     colorscheme = "gruvbox",
--   },
-- },
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- {
  --   "Alexis12119/nightly.nvim",
  --   lazy = true,
  --   priority = 1000,
  -- },
  -- { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nightflyCursorColor = true
      vim.g.nightflyItalics = false
      vim.g.nightflyNormalFloat = true
      vim.g.nightflyTerminalColors = true
      vim.g.nightflyTransparent = false
      vim.g.nightflyUndercurls = true
      vim.g.nightflyUnderlineMatchParen = true
      vim.g.nightflyVirtualTextColor = true
      vim.g.nightflyWinSeparator = 2

      vim.cmd([[colorscheme nightfly]])
    end,
  },

  {
    "marko-cerovac/material.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.material_style = "deep ocean"
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
  },

  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 1000,
  },

  {
    "navarasu/onedark.nvim",
    lazy = true,
    priority = 1000,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
  },

  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    priority = 1000,
  },
}
