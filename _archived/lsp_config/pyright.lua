local M = {}

function M.setup()
  require("lspconfig").pyright.setup({
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
  })
end

return M
