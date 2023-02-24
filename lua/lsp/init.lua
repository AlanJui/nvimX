local mason = _G.safe_require("mason")
local cmp = _G.safe_require("cmp")
local luasnip = _G.safe_require("luasnip")
local lspkind = _G.safe_require("lspkind")

if not mason or not cmp or not luasnip or not lspkind then
	return
end

------------------------------------------------------------------------
-- Variables for this Module
------------------------------------------------------------------------
_G.LspFormattingAugroup = vim.api.nvim_create_augroup("LspFormatting", {})

local nvim_config = _G.GetConfig()

------------------------------------------------------------------------
-- Automatic LSP Setup
--
-- Mason: Easily install and manage LSP servers, DAP servers, linters,
-- and formatters.
------------------------------------------------------------------------

mason.setup({
	install_root_dir = nvim_config["runtime"] .. "/mason",
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

-- `mason-lspconfig` provides extra, opt-in, functionality that allows you to
-- automatically set up LSP servers installed via `mason.nvim` without having to
-- manually add each server setup to your Neovim configuration. It also makes it
-- possible to use newly installed servers without having to restart Neovim!
require("mason-lspconfig").setup({
	ensure_installed = nvim_config["lsp_servers"],
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true,
})

------------------------------------------------------------
-- 透過 mason-tool-installer 自動安裝 Null-LS, DAP ；
-- 且自動更新所有的 LS 及 Null-LS
------------------------------------------------------------
if _G.safe_require("mason-tool-installer") then
	---@diagnostic disable-next-line: unused-local
	local ensure_installed_list = { -- luacheck: ignore
		-- DAP
		"debugpy",
		"js-debug-adapter",
		"node-debug2-adapter",
	}

	require("mason-tool-installer").setup({
		-- a list of all tools you want to ensure are installed upon
		-- start; they should be the names Mason uses for each tool
		ensure_installed = ensure_installed_list,
		-- if set to true this will check each tool for updates. If updates
		-- are available the tool will be updated. This setting does not
		-- affect :MasonToolsUpdate or :MasonToolsInstall.
		-- Default: false
		auto_update = true,
		-- automatically install / update on startup. If set to false nothing
		-- will happen on startup. You can use :MasonToolsInstall or
		-- :MasonToolsUpdate to install tools and check for updates.
		-- Default: true
		run_on_start = true,
		-- set a delay (in ms) before the installation starts. This is only
		-- effective if run_on_start is set to true.
		-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
		-- Default: 0
		start_delay = 3000, -- 3 second delay
	})
end

------------------------------------------------------------
-- Auto-complete and snippets setup: cmp.nvim + luasnip
-- 《Enter》：等同 cmp.mapping.confirm()
-- 《C-E》：關閉 Auto-complete 操作視窗
-- 《ESC》：等同 cmp.mapping.abort()
-- 《C-N》：跳至 Snippet 下一個欄位 luasnip.jumpable(1)
-- 《C-P》：跳至 Snippet 上一個欄位 luasnip.jumpable(-1)
----------------------------------------------------------
require("lsp/lsp-autocmp")

------------------------------------------------------------------------
-- Keybindings
------------------------------------------------------------------------
local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	-- Sync Formatting
	local augroup = _G.LspFormattingAugroup
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({
			on_attach = lsp_attach,
			capabilities = lsp_capabilities,
		})
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	-- ["rust_analyzer"] = function ()
	--     require("rust-tools").setup {}
	-- end,
	["lua_ls"] = function()
		-- lspconfig.lua_ls.setup(
		--     require("lsp/settings/lua_ls").setup(lsp_attach, lsp_capabilities)
		-- )
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
	["pyright"] = function()
		lspconfig.pyright.setup(require("lsp/settings/pyright").setup(lsp_attach, lsp_capabilities))
	end,
	["tsserver"] = function()
		lspconfig.tsserver.setup(require("lsp/settings/tsserver").setup(lsp_attach, lsp_capabilities))
	end,
	["jsonls"] = function()
		lspconfig.jsonls.setup(require("lsp/settings/jsonls").setup(lsp_attach, lsp_capabilities))
	end,
	["texlab"] = function()
		lspconfig.texlab.setup(require("lsp/settings/texlab").setup(lsp_attach, lsp_capabilities))
	end,
})

------------------------------------------------------------
-- Null-ls Setup
------------------------------------------------------------
require("lsp/lsp-null-ls").setup()

------------------------------------------------------------
-- Diagnostic Setup
------------------------------------------------------------
---@diagnostic disable-next-line: redefined-local
local sign = function(opts) -- luacheck: ignore
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = " " })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
