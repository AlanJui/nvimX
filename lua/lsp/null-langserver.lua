--------------------------------------------------------------------------
-- null-ls: https://github.com/jose-elias-alvarez/null-ls.nvim
-- Use Neovim as a language server to inject LSP diagnostics, code actions,
-- and more via Lua.
--------------------------------------------------------------------------
-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(current_client, bufnr)
	if current_client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					filter = function(client)
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

local sources = {
	-- Built-in sources have access to a special method, with(),
	-- which modifies a subset of the source's default options.
	null_ls.builtins.code_actions.gitsigns,
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
	}), -- Snippet engine for Neovim
	null_ls.builtins.completion.luasnip,
	---------------------------------------------------------------
	-- Python/Django
	---------------------------------------------------------------
	-- Pylint is a Python static code analysis tool which looks for
	-- programming errors, helps enforcing a coding standard, sniffs
	-- for code smells and offers simple refactoring suggestions.
	diagnostics.pylint.with({
		diagnostics_postprocess = function(diagnostic)
			diagnostic.code = diagnostic.message_id
		end,
	}),
	formatting.isort,
	formatting.autopep8, -- formatting.black,
	-- A pure-Python Django/Jinja template indenter without dependencies.
	formatting.djhtml,
	formatting.djlint,

	-- mypy is an optional static type checker for Python that aims to
	-- combine the benefits fo dynamic (or "dock") typing and static typings.
	-- diagnostics.mypy,

	-- pydocstyle is a static analysis tool for checking compliance
	-- with Python docstring conventions.
	-- diagnostics.pydocstyle,

	-- flake8 is a python tool that glues together pycodestyle,
	-- pyflakes, mccabe, and third-party plugins to check the style
	-- and quality of Python code.
	diagnostics.flake8,

	-- A tool that automatically formats Python code to conform to
	-- the PEP 8 style guide.
	-- Django HTML Template Linter and Formatter.
	diagnostics.djlint,
	---------------------------------------------------------------
	-- Lua
	---------------------------------------------------------------
	-- Snippet engine for Neovim, written in Lua.
	-- null_ls.builtins.completion.luasnip,
	-- for linting and static analysis of Lua code
	-- diagnostics.luacheck,
	-- Reformats your Lua source code.
	formatting.lua_format,
	---------------------------------------------------------------
	-- Web
	---------------------------------------------------------------
	-- Tags completion source.
	formatting.stylua,
	diagnostics.eslint, -- null_ls.builtins.completion.tags,
	-- null_ls.builtins.completion.spell,
	-- Find and fix problems in your JavaScript code.
	formatting.eslint,
	---------------------------------------------------------------
	-- Markdown style and syntax checker
	diagnostics.markdownlint,
	-- A Node.js style checker and lint tool for Markdown/CommonMark
	-- files.
	formatting.markdownlint,
	-- A linter for YAML files
	-- diagnostics.zsh,
}

null_ls.setup({ sources = sources, on_attach = on_attach })
