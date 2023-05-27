return {
	-- mason = false, -- set to false if you don't want this server to be installed with mason
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
			},
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "vim", "hs" },
			},
		},
	},
}
