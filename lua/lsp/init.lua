local lspconfig = _G.safe_require("lspconfig")
local mason = _G.safe_require("mason")
local mason_lspconfig = _G.safe_require("mason-lspconfig")
local mason_tool_installer = _G.safe_require("mason-tool-installer")
local cmp = _G.safe_require("cmp")
local luasnip = _G.safe_require("luasnip")
local lspkind = _G.safe_require("lspkind")

if not lspconfig or not mason or not mason_lspconfig or not mason_tool_installer then return end

if not cmp or not luasnip or not lspkind then return end

------------------------------------------------------------------------
-- Variables for this Module
------------------------------------------------------------------------
_G.LspFormattingAugroup = vim.api.nvim_create_augroup("LspFormatting", {})

local nvim_config = _G.GetConfig()

------------------------------------------------------------------------
-- Automatic LSP Setup
------------------------------------------------------------------------
local function setup_lsp_auto_installation()
	------------------------------------------------------------
	-- 透過 mason-tool-installer 自動安裝 Null-LS, DAP ；
	-- 且自動更新所有的 LS 及 Null-LS
	------------------------------------------------------------
	---@diagnostic disable-next-line: unused-local
	local ensure_installed_list = {
		"lua-language-server",
		"diagnostic-languageserver",
		"pyright",
		"pylint",
		"debugpy",
		"tailwindcss-language-server",
		"prettier",
		"typescript-language-server",
		"json-lsp",
		"eslint-lsp",
	}

	require("mason-tool-installer").setup({
		ensure_installed = ensure_installed_list,
		auto_update = true,
		run_on_start = true,
		start_delay = 3000, -- 3 second delay
	})

	-- Events
	-- vim.api.nvim_create_autocmd("User", {
	--   pattern = "MasonToolsStartingInstall",
	--   callback = function()
	--     vim.schedule(function() print("mason-tool-installer is starting") end)
	--   end,
	-- })

	-- vim.api.nvim_create_autocmd("User", {
	--   pattern = "MasonToolsUpdateCompleted",
	--   callback = function()
	--     vim.schedule(function() print("mason-tool-installer has finished") end)
	--   end,
	-- })
end

------------------------------------------------------------------------
-- Setup configuration for every LSP
------------------------------------------------------------------------
local function setup_lsp()
	-- 使用 LSP Saga 代替 LSP Key Bindings
	---@diagnostic disable-next-line: unused-local
	local lsp_attach = function(client, bufnr)
	end                                            -- luacheck: ignore

	local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

	------------------------------------------------------------------------
	-- Mason: Easily install and manage LSP servers, DAP servers, linters, and formatters.
	--
	-- `mason-lspconfig` provides extra, opt-in, functionality that allows you to
	-- automatically set up LSP servers installed via `mason.nvim` without having to
	-- manually add each server setup to your Neovim configuration. It also makes it
	-- possible to use newly installed servers without having to restart Neovim!
	------------------------------------------------------------------------
	mason.setup({
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
		},
	})

	mason_lspconfig.setup({
		ensure_installed = nvim_config["lsp_servers"],
		-- auto-install configured servers (with lspconfig)
		automatic_installation = true,
	})

	mason_lspconfig.setup_handlers({
		function(server_name) -- default handler (optional)
			lspconfig[server_name].setup({
				on_attach = lsp_attach,
				capabilities = lsp_capabilities,
			})
		end,
		["lua_ls"] = function()
			-- lspconfig.lua_ls.setup(
			--     require("lsp/settings/lua_ls").setup(lsp_attach, lsp_capabilities)
			-- )
			lspconfig.lua_ls.setup({
				on_attach = lsp_attach,
				capabilities = lsp_capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "hs" },
						},
					},
				},
			})
		end,
		["emmet_ls"] = function()
			lspconfig.emmet_ls.setup({
				on_attach = lsp_attach,
				capabilities = lsp_capabilities,
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
							-- For possible options,
							-- see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
							["bem.enabled"] = true,
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
		["jsonls"] = function() lspconfig.jsonls.setup(require("lsp/settings/jsonls").setup(lsp_attach, lsp_capabilities)) end,
		["texlab"] = function() lspconfig.texlab.setup(require("lsp/settings/texlab").setup(lsp_attach, lsp_capabilities)) end,
	})
end

------------------------------------------------------------
-- Setup Diagnostics
------------------------------------------------------------
local function setup_diagnostics()
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
end

------------------------------------------------------------
-- Main Program
------------------------------------------------------------

-- (1) 設定 LSP 自動安裝機制 (Automatic LSP Setup)
setup_lsp_auto_installation()

-- (2) 設定 Auto Completion (Auto-cmp and snippets setup: cmp.nvim + luasnip)
-- require("lsp/lsp-autocmp-copilot")
require("plugins-rc/copilot")
require("lsp/lsp-autocmp")

-- (3) 設定 LSP (Setup configuration for every LSP)
setup_lsp()

-- (4) 設定 Null Languager Server (Null-LS Setup)
require("lsp/lsp-null-ls")

-- (5) 設定 LSP Diagnostics (Setup Diagnostics)
setup_diagnostics()

-- (6) 設定 Lsp Saga
require("plugins-rc.lspsaga-nvim")
