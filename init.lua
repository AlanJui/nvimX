--------------------------------------------------------------------
-- Initial environment
--------------------------------------------------------------------
require('globals')
require('init-env')
require('essential')

--------------------------------------------------------------------
-- Neovim's plugins
--------------------------------------------------------------------
-- configure packer.nvim
require('add-on-plugins')

-- configure Neovim to automatically run :PackerCompile whenever
-- plugin-list.lua is updated with an autocommand:
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
require('lsp/luasnip')
require('lsp')  -- integrate with auto cmp
require('rc/autopairs')
-- code runner
require('rc/yabs').setup()

--------------------------------------------------------------------
-- Set key bindings
--------------------------------------------------------------------
require('keybindings')
require('rc/which-key-nvim')

--------------------------------------------------------------------
-- Experiment
--------------------------------------------------------------------

-- For folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Say hello
local function blah()
  print "hello world\n"
end
blah()
