local M = {}

function M.setup()
  require("lspconfig").emmet_ls.setup({
    filetypes = {
      "htmldjango",
      "html",
      "css",
      "scss",
      "typescriptreact",
      "javascriptreact",
      "markdown",
    },
    init_options = {
      html = {
        options = {
          ["bem.enabled"] = true,
        },
      },
    },
  })
end

return M
