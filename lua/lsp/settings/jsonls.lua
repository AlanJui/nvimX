local M = {}

function M.setup(on_attach, capabilities)
	return {
		on_attach = on_attach,
        capabilities = capabilities,
		filetypes = { "json", "jsonc" },
		settings = {
			json = {
				schemas = require("lsp/settings/json-schemas"),
			},
		},
		setup = {
			commands = {
				Format = {
					function()
						vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
					end,
				},
			},
		},
		init_options = {
			provideFormatter = true,
		},
		single_file_support = true,
	}
end

return M
