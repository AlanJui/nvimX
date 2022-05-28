-----------------------------------------------------------------------------------------------
-- (1) Start and setup nvim-lsp-installer
-----------------------------------------------------------------------------------------------
require("nvim-lsp-installer").setup({
    -- automatically detect which servers to install
    -- (based on which servers are set up via lspconfig)
	automatic_installation = true,
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

-----------------------------------------------------------------------------------------------
-- (2) Setup LSP client for connectting to LSP server
-----------------------------------------------------------------------------------------------
-- on_attach: to map keys after the languate server attaches to the current buffer
local on_attach = safe_require("lsp/on-attach")
if not on_attach then
	return
end

-- Capabilities
--------------------------------------------------------------------
require("lsp/auto-cmp")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------
local servers = LSP_SERVERS

-- Settings for servers
local servers_settings = require("lsp/server-settings")

for _, lsp in pairs(servers) do
	local setup_opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
	}

	-- Get configuration of specific server
	local custom_opts = servers_settings[lsp] or {}
	if custom_opts then
		setup_opts = vim.tbl_deep_extend("force", custom_opts, setup_opts)
	end

	require("lspconfig")[lsp].setup(setup_opts)
end
