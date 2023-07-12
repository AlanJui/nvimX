local M = {}

function M.setup()
  require("lspconfig").lua_ls.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "hs" },
        },
      },
    },
  })
end

return M
