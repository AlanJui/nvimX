--------------------------------------------------------------------
-- Initial environment
--------------------------------------------------------------------
require('globals')
require('essential')

--------------------------------------------------------------------
-- Neovim's plugins
--------------------------------------------------------------------
-- Install plugins
require('plugins')
-- Auto install plugin after plugins.lua file is upated and saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

--------------------------------------------------------------------
-- Configurations of Neovim
--------------------------------------------------------------------
require('settings')

--------------------------------------------------------------------
-- Set key bindings
--------------------------------------------------------------------
require('keybindings')
require('rc.which-key-nvim')
