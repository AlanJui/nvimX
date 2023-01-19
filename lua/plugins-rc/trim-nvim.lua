-- This plugin trims trailing whitespace and lines.
local ok, trim_nvim = pcall(require, "trim")
if not ok then
	return
end

trim_nvim.setup({
	trim_trailing = true,
	trim_last_line = true,
	trim_first_line = true,
	disable = {
		"markdown",
	},
	-- if you want to remove multiple blank lines
	-- patterns = {
	--   [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
	-- },
})
