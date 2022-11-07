------------------------------------------------------------
-- Setup LuaSnip integrate with nvim-cmp
------------------------------------------------------------
local luasnip = safe_require("luasnip")
if not luasnip then
	return
end

------------------------------------------------------------
-- Add Snippets
------------------------------------------------------------

-- Load your own custom vscode style snippets
require("luasnip.loaders.from_vscode").lazy_load({
	paths = {
		CONFIG_DIR .. "/my-snippets",
		RUNTIME_DIR .. "/site/pack/packer/start/friendly-snippets",
	},
})

require("luasnip").filetype_extend("vimwik", { "markdown" })
require("luasnip").filetype_extend("html", { "htmldjango" })

