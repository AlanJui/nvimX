--------------------------------------------------------------------------
-- WhichKey Configuration
--------------------------------------------------------------------------
local which_key = safe_require('which-key')
if not which_key then
  return
end
-- print('Plugin: which-key is installed')

local mappings = {
  -- Top Menu
  [' '] = { ':Telescope find_files<CR>', 'Find files' },
  [','] = { ':Telescope buffers<CR>', 'Show buffers' },
  [';'] = { ':FloatermNew --wintype=normal --height=10<CR>', 'Open Terminal' },
  ['/'] = { ':NvimTreeToggle<CR>', 'File explorer' },
  ['g'] = { ':Neogit<CR>', 'Git' },
  ['r'] = { ':FloatermNew ranger<CR>', 'Ranger' },
  ['v'] = { ':FloatermNew --height=0.7 --width=0.9 --wintype=float  vifm<CR>', 'ViFm' },
  -- Configure Neovim
  n = {
    name = 'Neovim',
    i = { ':e ~/.config/nvim/init.lua<CR>', 'nvim/init.lua' },
    I = { ':source ~/.config/nvim/init.lua<CR>', 'reload' },
    k = { ':e ~/.config/nvim/lua/keybindings.lua<CR>', 'keybindings' },
    K = { ':e ~/.config/nvim/lua/rc/which-key-nvim.lua<CR>', 'which-key' },
    s = { ':e ~/.config/nvim/lua/plugins.lua<CR>', 'specifying plugins' },
    S = { ':PackerSync<CR>', 'PackerSync' },
    c = {
      name = 'configuration',
      g = { ':e ~/.config/nvim/lua/globals.lua<CR>', 'globals' },
      e = { ':e ~/.config/nvim/lua/essential.lua<CR>', 'essential' },
      s = { ':e ~/.config/nvim/lua/settings.lua<CR>', 'settings' },
      n = { ':e ~/.config/nvim/lua/nvim_utils.lua<CR>', 'nvim_utils' },
      o = { ':e ~/.config/nvim/lua/options.lua<CR>', 'options' },
      u = { ':e ~/.config/nvim/lua/utils.lua<CR>', 'utils' },
      c = { ':e ~/.config/nvim/lua/color-themes.lua<CR>', 'colorscheme' },
    },
    C = { ':PackerCompile<CR>', 'PackerCompile' },
    l = {
      name = 'lsp',
      l = { ':Telescope git_files({cwd="~/.config/nvim/lua/lsp"})<CR>', 'list lsp configuration' },
      i = { ':e ~/.config/nvim/lua/lsp/init.lua<CR>', 'configure init' },
      o = { ':e ~/.config/nvim/lua/lsp/on-attach.lua<CR>', 'configure on-attach' },
      f = { ':e ~/.config/nvim/lua/lsp/format.lua<CR>', 'configure format' },
    },
  },
  -- Actions
  a = {
    name = 'actions',
    h = { ':let @/ = ""<CR>', 'remove search highlight' },
    t = { ':set filetype=htmldjango<CR>', 'set file type to django template' },
    T = { ':set filetype=html<CR>', 'set file type to HTML' },
    l = { ':set wrap!<CR>', 'on/off line wrap' },
    n = { ':set nonumber!<CR>', 'on/off line-numbers' },
    N = { ':set norelativenumber!<CR>', 'on/off relative line-numbers' },
  },
}

local opts = {
  prefix = '<leader>',
}

which_key.register(mappings, opts)

