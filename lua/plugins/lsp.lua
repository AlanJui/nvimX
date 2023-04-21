return {
  -- add lua, pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        lua_ls = {
          settings = {
            diagnostics = {
              globals = { "vim", "hs" },
            },
          },
        },
      },
    },
  },
}
