local M = {}

function M.setup(on_attach, capabilities)
	return {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			completion = {
				completeFunctionCalls = true,
				-- completePropertyWithSemicolon = true,
				-- completeJSDocs = true,
				-- autoImportSuggestions = true,
				-- importModuleSpecifier = "relative",
				-- importModuleSpecifierEnding = "minimal",
				-- importStatementCompletion = "auto",
				-- nameSuggestions = true,
				-- paths = {
				--     { kind = "pathCompletion", trigger = "./", value = "./" },
				--     { kind = "pathCompletion", trigger = "../", value = "../" },
				--     { kind = "pathCompletion", trigger = "/", value = "/" },
				-- },
			},
			-- documentFormatting = false,
			-- documentRangeFormatting = false,
		},
	}
end

return M
