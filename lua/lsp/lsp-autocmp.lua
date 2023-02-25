------------------------------------------------------------
-- Auto-complete and snippets setup: cmp.nvim + luasnip
-- 《Enter》：等同 cmp.mapping.confirm()
-- 《C-E》：關閉 Auto-complete 操作視窗
-- 《ESC》：等同 cmp.mapping.abort()
-- 《C-N》：跳至 Snippet 下一個欄位 luasnip.jumpable(1)
-- 《C-P》：跳至 Snippet 上一個欄位 luasnip.jumpable(-1)
----------------------------------------------------------
local cmp = _G.safe_require("cmp")
local luasnip = _G.safe_require("luasnip")
local lspkind = _G.safe_require("lspkind")

if not lspkind or not cmp or not luasnip then
	return
end

------------------------------------------------------------
-- Add Snippets
------------------------------------------------------------
local nvim_config = _G.GetConfig()

-- Load your own custom vscode style snippets
require("luasnip.loaders.from_vscode").lazy_load({
	paths = nvim_config["snippets"],
})

-- extends filetypes supported by snippets
luasnip.filetype_extend("vimwik", { "markdown" })
luasnip.filetype_extend("html", { "htmldjango" })

------------------------------------------------------------
-- Autocomplete
------------------------------------------------------------
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local select_opts = { behavior = cmp.SelectBehavior.Select }

local has_words_before = function()
	---@diagnostic disable-next-line: deprecated
	unpack = unpack or table.unpack -- luacheck: globals unpack (compatibility with Lua 5.1)
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

------------------------------------------------------------
-- integrate with copilot.vim
------------------------------------------------------------
-- disables the fallback mechanism of copilot.vim
vim.cmd([[
let g:copilot_no_tab_map = v:true
imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>")
]])

------------------------------------------------------------
cmp.setup({
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
		["<C-y>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),
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
		---@diagnostic disable-next-line: unused-local
		["<C-g>"] = cmp.mapping(function(fallback) -- luacheck: ignore
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
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 1 },
		{ name = "copilot" },
		{ name = "calc" },
		{ name = "emoji" },
	}, { { name = "buffer", keyword_length = 3 } }),
	formatting = {
		-- changing the order of fields so the icon is the first
		fields = { "abbr", "kind", "menu" },
		-- here is where the change happens
		format = lspkind.cmp_format({
			-- show only symbol annotations
			mode = "symbol_text",
			-- prevent the popup from showing more than provided characters
			-- (e.g 50 will not show more than 50 characters)
			maxwidth = 50,
			-- when popup menu exceed maxwidth, the truncated part would show
			-- ellipsis_char instead (must define maxwidth first)
			ellipsis_char = "...",
			-- The function below will be called before any actual modifications from
			-- lspkind so that you can provide more controls on popup customization.
			-- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
				return vim_item
			end,
		}),
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, { { name = "buffer" } }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
