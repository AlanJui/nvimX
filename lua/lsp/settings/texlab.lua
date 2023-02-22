local M = {}

function M.setup(on_attach)
	return {
		on_attach = on_attach,
		cmd = { "texlab" },
		filetypes = { "tex", "bib" },
		settings = {
			texlab = {
				-- rootDirectory = nil,
				-- --      ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓
				-- build = _G.TeXMagicBuildConfig,
				-- --      ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑ ↑
				-- forwardSearch = {
				--     executable = 'evince',
				--     args = { '%p' },
				-- },
				auxDirectory = ".",
				bibtexFormatter = "texlab",
				build = {
					args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
					executable = "latexmk",
					forwardSearchAfter = false,
					onSave = false,
				},
				chktex = {
					onEdit = false,
					onOpenAndSave = false,
				},
				diagnosticsDelay = 300,
				formatterLineLength = 80,
				forwardSearch = {
					args = {},
				},
				latexFormatter = "latexindent",
				latexindent = {
					modifyLineBreaks = false,
				},
			},
		},
	}
end

return M
