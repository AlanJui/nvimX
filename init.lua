--------------------------------------------------------------------
-- Initial environment
--------------------------------------------------------------------
require('globals')
require('init-env')
require('essential')

--------------------------------------------------------------------
-- Neovim's plugins
--------------------------------------------------------------------
-- Install plugins
require('plugins')
-- Auto install plugin after plugins.lua file is upated and saved
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]]

--------------------------------------------------------------------
-- Configurations of Neovim
--------------------------------------------------------------------
require('settings')
require('color-themes')
require('rc/nvim-treesitter')
require('lsp/luasnip')
-- require('lsp/auto-cmp')
require('lsp')
require('rc/autopairs')

--------------------------------------------------------------------
-- Set key bindings
--------------------------------------------------------------------
require('keybindings')
require('rc/which-key-nvim')

--------------------------------------------------------------------
-- Experiment
--------------------------------------------------------------------

-- Say hello
local function blah()
  print "hello world\n"
end
-- For folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

blah()
