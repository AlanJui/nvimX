-- autopairs.lua
local auto_pairs = safe_require('nvim-autopairs')
if not auto_pairs then
    return
end

auto_pairs.setup({
    check_ts = true,
})

auto_pairs.add_rules(
    require('nvim-autopairs.rules.endwise-lua')
)

-- Integrate with cmp (auto-compleption)
local cmp = safe_require('cmp')
local cmp_autopairs = safe_require('nvim-autopairs.completion.cmp')
if not cmp or not cmp_autopairs then
    return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

-- auto_pairs.setup {
--   check_ts = true,
--   ts_config = {
--     lua = { "string", "source" },
--     javascript = { "string", "template_string" },
--     java = false,
--   },
--   disable_filetype = { "TelescopePrompt", "spectre_panel" },
--   fast_wrap = {
--     map = "<M-e>",
--     chars = { "{", "[", "(", '"', "'" },
--     pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
--     offset = 0, -- Offset from pattern match
--     end_key = "$",
--     keys = "qwertyuiopzxcvbnmasdfghjkl",
--     check_comma = true,
--     highlight = "PmenuSel",
--     highlight_grey = "LineNr",
--   },
-- }
