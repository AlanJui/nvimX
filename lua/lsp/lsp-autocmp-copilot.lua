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
else
	-- Highlighting & Icon
	-- lspkind.init()
	vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

	-- Copilot.lua Support
	vim.cmd([[
    packadd copilot.lua
    packadd copilot-cmp
    ]])

	local copilot = _G.safe_require("copilot")
	local copilot_cmp = _G.safe_require("copilot_cmp")

	if copilot and copilot_cmp then
		copilot.setup({})
		copilot_cmp.setup({
			method = "getCompletionsCycling",
			formatters = {
				label = require("copilot_cmp.format").format_label_text,
				insert_text = require("copilot_cmp.format").format_insert_text,
				preview = require("copilot_cmp.format").deindent,
			},
		})
	end
end

local symbol_map = {
	Copilot = "",
	Text = "  ",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	Variable = "",
	Class = "ﴯ",
	Interface = "  ",
	Module = "",
	Property = "  ",
	Unit = "  ",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "  ",
	File = "  ",
	Reference = "  ",
	Folder = "  ",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "  ",
	Operator = "  ",
	TypeParameter = "  ",
}

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
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

------------------------------------------------------------
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-y>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			-- select = true,
			-- this is the important line
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
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
		["<Tab>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({
					behavior = cmp.SelectBehavior.Select,
				})
			else
				fallback()
			end
		end),
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
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sorting = {
		priority_weight = 2,
		comparators = {
			require("copilot_cmp.comparators").prioritize,
			require("copilot_cmp.comparators").score,

			-- Below is the default comparitor list and order for nvim-cmp
			cmp.config.compare.offset,
			-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	experimental = {
		ghost_text = false, -- this feature conflict with copilot.vim's preview.
	},
	sources = cmp.config.sources({
		-- Copilot Source
		{ name = "copilot", group_index = 2 },
		-- Other Sources
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "path", group_index = 2 },
		{ name = "luasnip", group_index = 2 },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "calc" },
		{ name = "emoji" },
	}, { { name = "buffer", keyword_length = 3 } }),
	window = {
		documentation = cmp.config.window.bordered(),
		completion = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({
				-- mode = "symbol",
				mode = "symbol_text",
				maxwidth = 50,
				symbol_map = symbol_map,
			})(entry, vim_item)
			local source_name = " : " .. string.upper(entry.source.name) .. ""
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. source_name .. ")"

			return kind
		end,
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
