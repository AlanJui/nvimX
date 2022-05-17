-- Set themes
-- vim.g.colors_name = 'molokai'

local COLOR_SCHEME = '/molokai/colors/molokai.vim'
local PLUGINS_PATH = '/site/pack/packer/start'
local COLOR_SCHEME_PATH = vim.fn.stdpath('data') .. PLUGINS_PATH .. COLOR_SCHEME

if vim.fn.empty(vim.fn.glob(COLOR_SCHEME_PATH)) > 0 then
  -- 預設的 color scheme 未尚安裝
  -- Default: $HOME/.local/share/nvim/
  vim.cmd([[ colorscheme solarized8_flat ]])
else
  -- 預設的 color scheme 套件已安裝，設定檔已存在
  vim.cmd [[ colorscheme molokai ]]
  ---------------------------------------------
  -- Tokyo Night Color Scheme Configuration
  -- vim.g.tokyonight_style = 'day'
  -- vim.g.tokyonight_style = 'night'
  ---------------------------------------------
  -- vim.cmd([[ colorscheme tokyonight ]])
  -- vim.g.tokyonight_style = 'storm'
  -- vim.g.tokyonight_italic_functions = true
  -- vim.g.tokyonight_dark_float = true
  -- vim.g.tokyonight_transparent = true
  -- vim.g.tokyonight_sidebars = {
  --   'qf',
  --   'vista_kind',
  --   'terminal',
  --   'packer',
  -- }
  -- -- Change the "hint" color to the "orange" color,
  -- -- and make the "error" color bright red
  -- vim.g.tokyonight_colors = {
  --   hint = 'orange',
  --   error = '#ff0000'
  -- }
end
