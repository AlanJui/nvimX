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
    a = { ':e ~/.config/nvim/lua/add-on-plugins.lua<CR>', 'configure packer.nvim' },
    p = { ':e ~/.config/nvim/lua/plugins.lua<CR>', 'specifying plugins' },
    k = { ':e ~/.config/nvim/lua/keybindings.lua<CR>', 'keybindings' },
    w = { ':e ~/.config/nvim/lua/rc/which-key-nvim.lua<CR>', 'which-key' },
    s = { ':source ~/.config/nvim/init.lua<CR>', 'reload' },
    S = { ':PackerSync<CR>', 'PackerSync' },
    C = { ':PackerCompile<CR>', 'PackerCompile' },
    c = {
      name = 'configuration',
      d = { ':e ~/.config/nvim/lua/rc<CR>', 'list files in rc dir' },
      r = { ':e ~/.config/nvim/lua/rc/plugin.lua', 'create rc for plugin' },
    },
    e = {
      name = 'environment',
      i = { ':e ~/.config/nvim/lua/init-env.lua<CR>', 'init environment' },
      g = { ':e ~/.config/nvim/lua/globals.lua<CR>', 'globals functions' },
      e = { ':e ~/.config/nvim/lua/essential.lua<CR>', 'essential for neovim' },
      o = { ':e ~/.config/nvim/lua/options.lua<CR>', 'plugins\'soptions' },
      s = { ':e ~/.config/nvim/lua/settings.lua<CR>', 'user\'s settings' },
      u = { ':e ~/.config/nvim/lua/utils.lua<CR>', 'utils' },
      n = { ':e ~/.config/nvim/lua/nvim_utils.lua<CR>', 'nvim_utils' },
      c = { ':e ~/.config/nvim/lua/color-themes.lua<CR>', 'colorscheme' },
    },
    l = {
      name = 'lsp',
      d = { ':e ~/.config/nvim/lua/lsp<CR>', 'list files in dir' },
      i = { ':e ~/.config/nvim/lua/lsp/init.lua<CR>', 'configure lsp main' },
      c = { ':e ~/.config/nvim/lua/lsp/auto-cmp.lua<CR>', 'configure auto-completion' },
      s = { ':e ~/.config/nvim/lua/lsp/luasnip.lua<CR>', 'configure snippets' },
      S = { ':e ~/.config/nvim/lua/lsp/server-settings.lua<CR>', 'configure server setting' },
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
  -- utilities
  u = {
    name = 'utilities',
    t = {
      name = 'terminal',
      d = { ':FloatermNew python manage.py shell<CR>', 'Django-admin Shell' },
      p = { ':FloatermNew python<CR>', 'Python shell' },
      n = { ':FloatermNew node<CR>', 'Node.js shell' },
      v = { ":FloatermNew --wintype='vsplit' --position='right'<CR>", 'Debug Term...' },
    },
    l = {
      name = 'LiveServer',
      l = { ':Bracey<CR>', 'start live server' },
      L = { ':BraceyStop<CR>', 'stop live server' },
      r = { ':BraceyReload<CR>', 'web page to be reloaded' },
    },
    m = {
      name = 'Markdown',
      m = { ':MarkdownPreview<CR>', 'start markdown preview' },
      M = { ':MarkdownPreviewStop<CR>', 'stop markdown preview' },
    },
    u = {
      name = 'UML',
      v = { ':PlantumlOpen<CR>', 'start PlantUML preview' },
      o = { ':PlantumlSave docs/diagrams/out.png<CR>', 'export PlantUML diagram' },
    },
    f = { ':FloatermNew vifm<CR>', 'ViFm' },
    p = { ':FloatermNew ranger<CR>', 'Picture Viewer' },
  },
}

local opts = {
  prefix = '<leader>',
}

which_key.register(mappings, opts)

