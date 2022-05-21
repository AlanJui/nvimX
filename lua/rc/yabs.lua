local yabs = safe_require('yabs')
if not yabs then
  return
end

local telescope = safe_require('telescope')
if not telescope then
  return
end

local M = {}

function M.setup()
  yabs:setup {
    languages = {
      -- Lua
      lua = {
        tasks = {
          run = {
            command = 'luafile %',
            type = 'lua',
          },
        },
      },
      -- Python
      python = {
        tasks = {
          run = {
            command = 'python %',
            output = 'terminal',
          },
          monitor = {
            command = 'nodemon -e py %',
            output = 'terminal',
          },
        },
      },
      -- Others
      -- ...
    },
  }
  telescope.load_extension "yabs"
end

return M
