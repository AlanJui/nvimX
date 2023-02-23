local mason = _G.safe_require("mason")
local cmp = _G.safe_require("cmp")
local luasnip = _G.safe_require("luasnip")
local lspkind = _G.safe_require("lspkind")

if not mason or not cmp or not luasnip or not lspkind then
	return
end

local nvim_config = _G.GetConfig()
------------------------------------------------------------------------
-- Automatic LSP Setup
------------------------------------------------------------------------
require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = nvim_config["lsp_servers"],
})

------------------------------------------------------------
-- 透過 mason-tool-installer 自動安裝 Null-LS ；
-- 且自動更新所有的 LS 及 Null-LS
------------------------------------------------------------
if _G.safe_require("mason-tool-installer") then
	local ensure_installed_list = {
		"bash-language-server",
		"lua-language-server",
		"pyright",
		"luacheck",
		"stylua",
		"shellcheck",
		"debugpy",
		"mypy",
		"pydocstyle",
		-- "djlint",
		"isort",
		"autopep8",
		"black",
		"flake8",
		"jq",
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
require("lsp/lso-autocmp")

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

-- Create your keybindings here...
local lsp_attach = require("lsp/lsp-on-attach").get_keymap()

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = lsp_attach,
			capabilities = lsp_capabilities,
		})
	end,
})

------------------------------------------------------------
-- Null-ls Setup
------------------------------------------------------------
local null_ls = _G.safe_require("null-ls")
if not null_ls then
	return
end

-- to setup format on save
local lsp_format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls_on_attach = function(current_client, bufnr)
	if current_client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = lsp_format_augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = lsp_format_augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					filter = function(client) -- luacheck: ignore
						--  only use null-ls for formatting instead of lsp server
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end,
		})
	end
end

-- register any number of sources simultaneously
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local completion = null_ls.builtins.completion
local code_actions = null_ls.builtins.code_actions

local null_ls_sources = {
	-- Built-in sources have access to a special method, with(),
	-- which modifies a subset of the source's default options.
	code_actions.gitsigns,
	---------------------------------------------------------------
	-- Lua
	---------------------------------------------------------------
	-- Snippet engine for Neovim, written in Lua.
	completion.luasnip,
	-- for linting and static analysis of Lua code
	diagnostics.luacheck,
	-- Reformats your Lua source code.
	-- formatting.lua_format,
	formatting.stylua,
	---------------------------------------------------------------
	-- Web
	---------------------------------------------------------------
	-- Tags completion source.
	diagnostics.eslint, -- null_ls.builtins.completion.tags,
	-- null_ls.builtins.completion.spell,
	-- Find and fix problems in your JavaScript code.
	-- formatting.eslint,
	formatting.prettier.with({
		filetypes = {
			"html",
			"css",
			"scss",
			"less",
			"javascript",
			"typescript",
			"vue",
			"json",
			"jsonc",
			"yaml",
			"markdown",
			"handlebars",
		},
		extra_filetypes = {},
	}),
	---------------------------------------------------------------
	-- Python/Django
	---------------------------------------------------------------
	-- Pylint is a Python static code analysis tool which looks for
	-- programming errors, helps enforcing a coding standard, sniffs
	-- for code smells and offers simple refactoring suggestions.
	-- diagnostics.pylint,
	-- diagnostics.pylint.with({
	-- 	diagnostics_postprocess = function(diagnostic)
	-- 		diagnostic.code = diagnostic.message_id
	-- 	end,
	-- }),
	formatting.isort,
	formatting.autopep8,
	-- formatting.black,
	-- A pure-Python Django/Jinja template indenter without dependencies.
	formatting.djhtml,
	formatting.djlint,

	-- mypy is an optional static type checker for Python that aims to
	-- combine the benefits fo dynamic (or "dock") typing and static typings.
	diagnostics.mypy,

	-- pydocstyle is a static analysis tool for checking compliance
	-- with Python docstring conventions.
	diagnostics.pydocstyle,

	-- flake8 is a python tool that glues together pycodestyle,
	-- pyflakes, mccabe, and third-party plugins to check the style
	-- and quality of Python code.
	diagnostics.flake8,

	-- A tool that automatically formats Python code to conform to
	-- the PEP 8 style guide.
	-- Django HTML Template Linter and Formatter.
	diagnostics.djlint,
	---------------------------------------------------------------
	-- Markdown style and syntax checker
	diagnostics.markdownlint,
	-- A Node.js style checker and lint tool for Markdown/CommonMark
	-- files.
	formatting.markdownlint,
	-- A linter for YAML files
	diagnostics.zsh,
}

null_ls.setup({
	on_attach = null_ls_on_attach,
	sources = null_ls_sources,
})

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
if _G.safe_require("mason-null-ls") then
	require("mason-null-ls").setup({
		ensure_installed = nil,
		-- You can still set this to `true`
		automatic_installation = false,
		automatic_setup = true,
	})
	-- Required when `automatic_setup` is true
	require("mason-null-ls").setup_handlers()
end

------------------------------------------------------------
-- Diagnostic Setup
------------------------------------------------------------
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = true,
})
