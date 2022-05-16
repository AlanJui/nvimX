-----------------------------------------------------------
-- Plugin Manager: install plugins
-- $ nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
-----------------------------------------------------------

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

-- Load plugins
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tomasr/molokai'

  -----------------------------------------------------------
  -- Treesitter: for better syntax
  -----------------------------------------------------------

  -- Nvim Treesitter configurations and abstraction layer
  use({
    'nvim-treesitter/nvim-treesitter',
  })
  use({
    'JoosepAlviste/nvim-ts-context-commentstring',
  })  

  -- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
  use({
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function() require('rc/neogit') end,
  })
  -- Floatting terminal
  use 'voldikss/vim-floaterm'

  -- Toggle comments in Neovim
  use { 'tpope/vim-commentary' }

  -- Screen Navigation
  use { 'folke/which-key.nvim' }

  -- colorscheme for neovim written in lua specially made for roshnvim
  use('folke/tokyonight.nvim')

  -- Fuzzy files finder
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-raw.nvim' },
    },
    config = function() require('rc/telescope-nvim') end,
  })

  -- Icons
  use({
    'kyazdani42/nvim-web-devicons',
    config = function() require('rc/nvim-web-devicons') end,
  })

  -- File/Flolders explorer:nvim-tree
  use({
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require('rc/nvim-tree') end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)



