-- --------------------------------------------------------------------
-- Integrate Way: Lsp + Mason + Null-ls + Cmp
--------------------------------------------------------------------
require("plugins-rc/copilot")
require("plugins-rc/lspsaga-nvim")

local ok, lsp = pcall(require, "lsp-zero")
if not ok then
	return
end

------------------------------------------------------------------------
-- Main process
------------------------------------------------------------------------

------------------------------------------------------------------------
-- (1) Configure Environment for lsp-zero
------------------------------------------------------------------------
-- lsp.preset("recommended")

-- reserve space for diagnostic icons
vim.opt.signcolumn = "yes"

lsp.preset({
	name = "minimal",
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = false,
})

-- make sure this servers are installed
-- see :help lsp-zero.ensure_installed()

-- 務必安裝之 LSP Server 清單
-- LSP_SERVERS Table 設定內容，參考：essential.lua
local nvim_config = _G.GetConfig()
lsp.ensure_installed(nvim_config["lsp_servers"])

------------------------------------------------------------------------
-- (2) Configure Keybindings
------------------------------------------------------------------------

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
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

	-- <<Buffer formats twice>>
	-- This can happen because the built-in function for formatting (vim.lsp.buf.format())
	-- uses every server with "formatting capabilities" enabled.
	-- You can disable an LSP server formatting capabilities like this:
	if client.name == "volar" or client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end
end

------------------------------------------------------------
-- Auto-complete and snippets setup: cmp.nvim + luasnip
-- cmp 預設
-- 《Enter》：等同 cmp.mapping.confirm() ，參考以下之《C-y》
-- 《ESC》：等同 cmp.mapping.abort()
-- 《C-d》：跳至下一個欄位 luasnip.jumpable(1)
-- 《C-b》：跳至上一個欄位 luasnip.jumpable(-1)
----------------------------------------------------------
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
	return
end

local select_opts = { behavior = cmp.SelectBehavior.Select }
local cmp_sources = lsp.defaults.cmp_sources()

table.insert(cmp_sources, { name = "copilot" })

local has_words_before = function()
	---@diagnostic disable-next-line: deprecated
	unpack = unpack or table.unpack -- luacheck: globals unpack (compatibility with Lua 5.1)
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_config = {
	preselect = "none",
	completion = {
		completeopt = "menu,menuone,noinsert,noselect",
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	-- mapping = cmp.mapping.preset.insert(my_mapping),
	mapping = lsp.defaults.cmp_mappings({
		-- go to next placeholder in the snippet
		["<C-n>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		-- go to previous placeholder in the snippet
		["<C-p>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		-- ---@diagnostic disable-next-line: unused-local
		-- ["<C-g>"] = cmp.mapping(function(fallback) -- luacheck: ignore
		-- 	vim.api.nvim_feedkeys(
		-- 		vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<Tab>", true, true, true)),
		-- 		"n",
		-- 		true
		-- 	)
		-- end),

		-- ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		-- ["<Down>"] = cmp.mapping.select_next_item(select_opts),

		-- ["<C-e>"] = cmp.mapping.complete(),
		-- ["<C-e>"] = cmp.mapping.abort(),
		-- ["<C-y>"] = cmp.mapping.confirm({ select = true }),
		-- ["<CR>"]  = cmp.mapping.confirm({ select = true }),

		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	elseif has_words_before() then
		-- 		cmp.complete()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
		--
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, { "i", "s" }),
	}),
	experimental = {
		ghost_text = false, -- this feature conflict with copilot.vim's preview.
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip", keyword_length = 1 },
		{ name = "copilot" },
		{ name = "calc" },
		{ name = "emoji" },
	}, { { name = "buffer", keyword_length = 3 } }),
	formatting = {
		format = lspkind.cmp_format({
			-- show only symbol annotations
			mode = "symbol_text",
			-- prevent the popup from showing more than provided characters
			-- (e.g 50 will not show more than 50 characters)
			maxwidth = 50,
			-- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
			-- (must define maxwidth first)
			ellipsis_char = "...",
			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization.
			-- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				-- vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					luasnip = "[Snippet]",
					nvim_lua = "[Nvim Lua]",
					buffer = "[Buffer]",
				})[entry.source.name]

				vim_item.dup = ({
					luasnip = 0,
					nvim_lsp = 0,
					nvim_lua = 0,
					buffer = 0,
				})[entry.source.name] or 0

				return vim_item
			end,
		}),
	},
}

------------------------------------------------------------
-- integrate cmp.nvim with copilot.vim
------------------------------------------------------------
-- disables the fallback mechanism of copilot.vim
-- vim.cmd([[
-- let g:copilot_no_tab_map = v:true
-- imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>")
-- ]])
lsp.setup_nvim_cmp(cmp_config)

------------------------------------------------------------------------
-- (3) Configure and Setup LSP
------------------------------------------------------------------------

lsp.set_preferences({
	suggest_lsp_servers = false,
	setup_servers_on_start = true,
	set_lsp_keymaps = true,
	configure_diagnostics = true,
	cmp_capabilities = true,
	manage_nvim_cmp = true,
	call_servers = "local",
	sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "⚑",
		info = "",
	},
})

-- don't initialize this language server
-- we will use rust-tools to setup rust_analyzer
lsp.skip_server_setup({ "rust_analyzer" })

-- the function below will be executed whenever
-- a language server is attached to a buffer
-- lsp.on_attach(function(client, bufnr)
-- 	print("Greetings from on_attach")
-- end)
lsp.on_attach(on_attach)

-- pass arguments to a language server
-- see :help lsp-zero.configure()

-- Fix Undefined global 'vim'
-- lsp.configure("texlab", require("lsp/settings/jsonls").setup(on_attach))
-- lsp.configure("texlab", require("lsp/settings/lua_ls").setup(on_attach))
-- lsp.configure("texlab", require("lsp/settings/pyright").setup(on_attach))
-- lsp.configure("texlab", require("lsp/settings/tsserver").setup(on_attach))
-- lsp.configure("texlab", require("lsp/settings/texlab").setup(on_attach))

-- share configuration between multiple servers
-- see :help lsp-zero.setup_servers()
lsp.setup_servers({
	"eslint",
	-- "angularls",
	-- "vuels",
	opts = {
		single_file_support = false,
		on_attach = on_attach,
	},
})

-- configure lua language server for neovim
-- see :help lsp-zero.nvim_workspace()
lsp.nvim_workspace()

lsp.setup()

-- initialize rust_analyzer with rust-tools
-- see :help lsp-zero.build_options()
local rust_lsp = lsp.build_options("rust_analyzer", {
	single_file_support = false,
	on_attach = on_attach,
})

require("rust-tools").setup({ server = rust_lsp })
vim.diagnostic.config({ virtual_text = true })

------------------------------------------------------------
-- (4) Configure Diagnostics
------------------------------------------------------------

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = true,
})

------------------------------------------------------------
-- (5) Add Snippets
------------------------------------------------------------
-- Load your own custom vscode style snippets
local CONFIG_DIR = vim.fn.stdpath("config")
local RUNTIME_DIR = vim.fn.stdpath("data")
require("luasnip.loaders.from_vscode").lazy_load({
	paths = {
		CONFIG_DIR .. "/my-snippets",
		RUNTIME_DIR .. "/site/pack/packer/start/friendly-snippets",
	},
})
-- extends filetypes supported by snippets
luasnip.filetype_extend("vimwik", { "markdown" })
luasnip.filetype_extend("html", { "htmldjango" })

------------------------------------------------------------
-- (6) Integrate with null-ls
------------------------------------------------------------
require("plugins-rc/mason-tool-installer-rc")

local null_ls = _G.safe_require("null-ls")
if not null_ls or not lsp then
	return
end

-- Format buffer using only null-ls
--
-- local null_opts = lsp.build_options("null-ls", {})
-- local null_ls_on_attach = function(client, bufnr)
-- 	null_opts.on_attach(client, bufnr)
--
-- 	local format_cmd = function(input)
-- 		vim.lsp.buf.format({
-- 			id = client.id,
-- 			timeout_ms = 5000,
-- 			async = input.bang,
-- 		})
-- 	end
--
-- 	local bufcmd = vim.api.nvim_buf_create_user_command
-- 	bufcmd(bufnr, "NullFormat", format_cmd, {
-- 		bang = true,
-- 		range = true,
-- 		desc = "Format using null-ls",
-- 	})
-- end

-- to setup format on save
local null_opts = lsp.build_options("null-ls", {})
local lsp_format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls_on_attach = function(current_client, bufnr)
	null_opts.on_attach(current_client, bufnr)
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

if not _G.safe_require("mason-null-ls") then
	return
end

-- See mason-null-ls.nvim's documentation for more details:
-- https://github.com/jay-babu/mason-null-ls.nvim#setup
require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = false, -- You can still set this to `true`
	automatic_setup = true,
})

-- Required when `automatic_setup` is true
require("mason-null-ls").setup_handlers()
