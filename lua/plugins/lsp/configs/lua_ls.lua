return {
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim", "hs" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
  -- -- mason = false, -- set to false if you don't want this server to be installed with mason
  -- settings = {
  --   Lua = {
  --     workspace = {
  --       checkThirdParty = false,
  --     },
  --     completion = {
  --       callSnippet = "Replace",
  --     },
  --     diagnostics = {
  --       globals = { "vim", "hs" },
  --     },
  --   },
  -- },
}
