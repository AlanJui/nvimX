local my_mapping = {
	-- luacheck: ignore
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
	["<C-g>"] = cmp.mapping(function(fallback) -- luacheck: ignore
		vim.api.nvim_feedkeys(
			vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<Tab>", true, true, true)),
			"n",
			true
		)
	end),
}
local my_cmp_sources = cmp.config.sources({ -- luacheck: ignore
	{ name = "path" },
	{ name = "copilot" },
	{ name = "luasnip", keyword_length = 1 },
	{ name = "nvim_lsp", keyword_length = 1 },
	{ name = "nvim_lua" },
	{ name = "calc" },
	{ name = "emoji" },
}, { { name = "buffer", keyword_length = 3 } })
