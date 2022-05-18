------------------------------------------------------------
-- Setup LuaSnip integrate with nvim-cmp
------------------------------------------------------------

local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')
local cmp = prequire("cmp")

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if cmp and cmp.visible() then
    cmp.select_next_item()
  elseif luasnip and luasnip.expand_or_jumpable() then
    return t('<Plug>luasnip-expand-or-jump')
  elseif check_back_space() then
    return t('<Tab>')
  else
    cmp.complete()
  end
  return ''
end
_G.s_tab_complete = function()
  if cmp and cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip and luasnip.jumpable(-1) then
    return t('<Plug>luasnip-jump-prev')
  else
    return t('<S-Tab>')
  end
  return ''
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<C-E>', '<Plug>luasnip-next-choice', {})
vim.api.nvim_set_keymap('s', '<C-E>', '<Plug>luasnip-next-choice', {})

------------------------------------------------------------
-- Add Snippets
------------------------------------------------------------

-- Load Vscode-like snippets:
-- To use existing vs-code style snippets from a plugin
-- (eg. rafamadriz/friendly-snippets)
--
require('luasnip.loaders.from_vscode').lazy_load()

-- Load your own custom vscode style snippets
-- Path format: path/of/your/nvim/config/my-snippets
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-snippets" } })
require('luasnip.loaders.from_vscode').lazy_load({ paths = { '~/.config/my-nvim/my-snippets/' } })

require('luasnip').filetype_extend('vimwik', {'markdown'})
require('luasnip').filetype_extend('htmldjango', { 'html' })
