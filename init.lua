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
require('color-themes')
require('rc/nvim-treesitter')

--------------------------------------------------------------------
-- Set key bindings
--------------------------------------------------------------------
require('keybindings')
require('rc/which-key-nvim')


local function blah()
  print "hello world\n"
end
--------------------------------------------------------------------
-- Experiment
--------------------------------------------------------------------
-- For folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
