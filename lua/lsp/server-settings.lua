local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local settings = {
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            vim.api.nvim_get_runtime_file('', true),
          },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  texlab = {
    cmd = { 'texlab' },
    filetypes = { 'tex', 'bib' },
    settings = {
      texlab = {
        rootDirectory = nil,
        --      ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓
        build = _G.TeXMagicBuildConfig,
        --      ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
        forwardSearch = {
          executable = 'evince',
          args = { '%p' },
        },
      },
    },
  },
  pyright = {
    filetypes = { 'python' },
    settings = {
      python = {
        analysis = {
          diagnosticMode = 'workspace',
          typeCheckingMode = 'off',
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          logLevel = 'Error',
        },
        linting = {
          pylintArgs = {
            '--load-plugins=pylint_django',
            '--load-plugins=pylint_dango.checkers.migrations',
            '--errors-only',
          },
        },
      },
    },
    single_file_support = true,
  },
  emmet_ls = {
    filetypes = {
      'html',
      'htmldjango',
      'css',
    },
    single_file_support = true,
  },
  html = {
    filetypes = { 'html', 'htmldjango' },
    init_options = {
      configurationSection = { 'html', 'htmldjango', 'css', 'javascript' },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
    },
    settings = {},
    single_file_support = true,
  },
  jsonls = {
    filetypes = { 'json', 'jsonc' },
    settings = {
      json = {
        schemas = require('lsp/json-schemas'),
      },
    },
    setup = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
          end,
        },
      },
    },
    init_options = {
      provideFormatter = true,
    },
    single_file_support = true,
  },
}

return settings
