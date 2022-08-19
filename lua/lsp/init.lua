--------------------------------------------------------------------
-- Main Process
--------------------------------------------------------------------
-- (1) Setup lsp-installer
-- (2) Setup LSP Client
-- (3) Setup UI for Diagnostic
-----------------------------------------------------------
local lsp_installer = safe_require("nvim-lsp-installer")
local lsp_config = safe_require("lspconfig")
if not lsp_installer or not lsp_config then
	return
end

-----------------------------------------------------------------------------------------------
-- (1) Start and setup nvim-lsp-installer
-----------------------------------------------------------------------------------------------
lsp_installer.setup({
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
	-- The directory in which to installl servers.
	-- install_root_dir = RUNTIME_DIR .. '/lsp_servers',
	-- install_root_dir = '/Users/alanjui/.local/share/my-nvim' .. '/lsp_servers',
	install_root_dir = RUNTIME_DIR .. "/lsp_servers",
})

-----------------------------------------------------------------------------------------------
-- (2) Setup LSP client for connectting to LSP server
-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------
-- on_attach: to map keys after the languate server attaches to the current buffer
-----------------------------------------------------------------------------------------------
-- local on_attach = require('lsp/on-attach') or {}
local on_attach = safe_require("lsp/on-attach")
if not on_attach then
	on_attach = nil
end

-----------------------------------------------------------------------------------------------
-- Capabilities
-----------------------------------------------------------------------------------------------

-- Setup nvim-cmp plugin
require("lsp/auto-cmp")

-- Initial capabilities option for LSP client
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-----------------------------------------------------------------------------------------------
-- Get extra setup options and setup for LSP server
-----------------------------------------------------------------------------------------------
local servers = LSP_SERVERS

for _, lsp in pairs(servers) do
	if lsp == "cssls" then
		-- Enable (broadcasting) snippet capability for completion
		capabilities.textDocument.completion.completionItem.snippetSupport = true
	end

	local setup_opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
	}

	-- Get configuration of specific server
	-- local custom_opts = servers_settings[lsp] or {}
	-- if custom_opts then
	-- 	setup_opts = vim.tbl_deep_extend("force", custom_opts, setup_opts)
	-- end
	local has_custom_opts, lsp_custom_opts = pcall(require, "lsp.settings." .. lsp)
	if has_custom_opts then
		setup_opts = vim.tbl_deep_extend("force", lsp_custom_opts, setup_opts)
	end

	lsp_config[lsp].setup(setup_opts)
end

-----------------------------------------------------------------------------------------------
---- (3) Setup UI for Diannostics (Lint)
-----------------------------------------------------------------------------------------------

---- Customizing how diagnostics are displayed
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	-- disable virtual text
	-- virtual_text = false,
	-- underline = false,
    underline = {
        severity = { max = vim.diagnostic.severity.INFO }
    },
	virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN }
	},
	-- show signs
	signs = true,
})

-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Filter by severity in sign column
local orig_set_signs = vim.lsp.diagnostic.set_signs
local set_signs_limited = function(diagnostics, bufnr, client_id, sign_ns, opts)
	opts = opts or {}
	opts.severity_limit = "Error"
	orig_set_signs(diagnostics, bufnr, client_id, sign_ns, opts)
end
vim.lsp.diagnostic.set_signs = set_signs_limited

-- -- Print diagnostics to message area
-- function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--   bufnr = bufnr or 0
--   line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--   opts = opts or {['lnum'] = line_nr}

--   local line_diagnostics = vim.diagnostic.get(bufnr, opts)
--   if vim.tbl_isempty(line_diagnostics) then return end

--   local diagnostic_message = ""
--   for i, diagnostic in ipairs(line_diagnostics) do
--     diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--     print(diagnostic_message)
--     if i ~= #line_diagnostics then
--       diagnostic_message = diagnostic_message .. "\n"
--     end
--   end
--   vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
-- end

-- vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]

-- -- Highlight line number instead of having icons in sign column
-- vim.cmd([[
--   highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
--   highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
--   highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
--   highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

--   sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
--   sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
--   sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
--   sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
-- ]])

---- Setup UI: hover and popup dispalyed contents
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
