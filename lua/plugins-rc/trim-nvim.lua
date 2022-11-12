-- This plugin trims trailing whitespace and lines.
local trim_nvim = safe_require('trim')
if not trim_nvim then
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
