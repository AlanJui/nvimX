-----------------------------------------------------------
-- Plugin Manager: install plugins
-- $ nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
-----------------------------------------------------------

local plugins_list = {
  -- { 'wbthomason/packer.nvim' },
  -- colorscheme for neovim written in lua specially made for roshnvim
  { 'tomasr/molokai' },
  { 'folke/tokyonight.nvim' },
  -----------------------------------------------------------
  -- LSP
  -----------------------------------------------------------
  {
    "williamboman/nvim-lsp-installer",
    "neovim/nvim-lspconfig",
  },
  -----------------------------------------------------------
  -- Treesitter: for better syntax
  -----------------------------------------------------------
  -- Nvim Treesitter configurations and abstraction layer
  { 'nvim-treesitter/nvim-treesitter' },
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  -- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
  {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function() require('rc/neogit') end,
  },
  -- Floatting terminal
  { 'voldikss/vim-floaterm' },
  -- Toggle comments in Neovim
  { 'tpope/vim-commentary' },
  -- Screen Navigation
  { 'folke/which-key.nvim' },
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
}

local package_root = PACKAGE_ROOT
local compile_path = COMPILE_PATH
local install_path = INSTALL_PATH
local packer_bootstrap

-----------------------------------------------------------------
-- 確認 packer.nvim 套件已安裝，然後再「載入」及「更新」。
-----------------------------------------------------------------

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  -- 已知 packer.nvim 套件尚未安裝之處理作業
  packer_bootstrap = vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  }
  -- execute packadd for packer.nvim
  vim.api.nvim_command('packadd packer.nvim')
end

-- 確認套件 packer.nvim 已被安裝，且已被載入 nvim
local ok, packer = pcall(require, 'packer')
if not ok then
  return
end

packer.init {
  package_root = package_root,
  compile_path = compile_path,
  plugin_package = 'packer',
  display = {
    open_fn = require('packer.util').float,
  },
}

-- 確認 packer.nvim 已能運作後，處理 nvim 套件安裝作業
local plugins = plugins_list

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  if not DEBUG then
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  else
    use 'neovim/nvim-lspconfig'
  end
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
