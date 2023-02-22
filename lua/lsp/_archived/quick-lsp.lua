local ok, lsp = pcall(require, "lsp-zero")
if not ok then
	return
end

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
end

------------------------------------------------------------------------
-- Main process
------------------------------------------------------------------------
lsp.preset("recommended")

local nvim_config = _G.GetConfig()

-- 務必安裝之 LSP Server 清單
-- LSP_SERVERS Table 設定內容，參考：essential.lua
lsp.ensure_installed(nvim_config["lsp_servers"])

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
					"hs",
				},
			},
		},
	},
})

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

local has_words_before = function()
	unpack = unpack or table.unpack -- luacheck: globals unpack (compatibility with Lua 5.1)
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_config = {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),

		-- ["<C-b>"] = cmp.mapping.select_prev_item(select_opts),
		-- ["<C-f>"] = cmp.mapping.select_next_item(select_opts),

		-- ["<C-u>"] = cmp.mapping.scroll_docs(-4),
		-- ["<C-d>"] = cmp.mapping.scroll_docs(4),

		["<C-=>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		["<C-n>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-g>"] = cmp.mapping(function(fallback) -- luacheck: ignore unused argument 'fallback'
			vim.api.nvim_feedkeys(
				vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<Tab>", true, true, true)),
				"n",
				true
			)
		end),
	}),
	experimental = {
		ghost_text = false, -- this feature conflict with copilot.vim's preview.
	},
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "copilot" },
		{ name = "luasnip", keyword_length = 1 },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "nvim_lua" },
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
vim.cmd([[
let g:copilot_no_tab_map = v:true
imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>")
]])
lsp.setup_nvim_cmp(cmp_config)

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

lsp.on_attach(on_attach)

lsp.setup()

vim.diagnostic.config({ virtual_text = true })

------------------------------------------------------------
-- Add Snippets
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
