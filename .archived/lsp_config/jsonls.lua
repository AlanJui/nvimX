local M = {}

function M.setup()
  require("lspconfig").jsonls.setup({
    filetypes = { "json", "jsonc" },
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
        end,
      },
    },
    init_options = {
      provideFormatter = true,
    },
    single_file_support = true,
  })
end

return M
