-- autopairs.lua
local status, npairs = pcall(require, "nvim-autopairs")
if not status then
	return
end

local Rule = require("nvim-autopairs.rule")

npairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
		javascript = { "template_string" },
		python = { "template_string" },
		java = false, -- don't check treesitter on java
	},
})

local ts_conds = require("nvim-autopairs.ts-conds")

-- press % => %% only while inside a comment or string
npairs.add_rules({
	Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
	Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
})

-- remove add single quote on filetype scheme or lisp
require("nvim-autopairs").get_rule("'")[1].not_filetypes = { "scheme", "lisp" }

-- npair.add_rules(require("nvim-autopairs.rules.endwise-lua"))

-- Integrate with cmp (auto-compleption)
local cmp = _G.safe_require("cmp")
local cmp_autopairs = _G.safe_require("nvim-autopairs.completion.cmp")
if not cmp or not cmp_autopairs then
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
