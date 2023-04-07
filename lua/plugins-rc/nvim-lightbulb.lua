-- The plugin shows a lightbulb in the sign column whenever a
-- textDocument/codeAction is available at the current cursor
-- position.
--
-- This makes code actions both discoverable and efficient,
-- as code actions can be available even when there are no
-- visible diagnostics (warning, information, hints etc.).
local nvim_light_bulb = _G.safe_require("nvim-lightbulb")
if not nvim_light_bulb then
    return
end

-- Configuration for Available options
-- Showing defaults
-- require'nvim-lightbulb'.update_lightbulb {
nvim_light_bulb.update_lightbulb({
    -- LSP client names to ignore
    -- Example: {"sumneko_lua", "null-ls"}
    ignore = {},
    sign = {
        enabled = true,
        -- Priority of the gutter sign
        priority = 10,
    },
    float = {
        enabled = false,
        -- Text to show in the popup float
        text = "💡",
        -- Available keys for window options:
        -- - height     of floating window
        -- - width      of floating window
        -- - wrap_at    character to wrap at for computing height
        -- - max_width  maximal width of floating window
        -- - max_height maximal height of floating window
        -- - pad_left   number of columns to pad contents at left
        -- - pad_right  number of columns to pad contents at right
        -- - pad_top    number of lines to pad contents at top
        -- - pad_bottom number of lines to pad contents at bottom
        -- - offset_x   x-axis offset of the floating window
        -- - offset_y   y-axis offset of the floating window
        -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
        -- - winblend   transparency of the window (0-100)
        win_opts = {},
    },
    virtual_text = {
        enabled = false,
        -- Text to show at virtual text
        text = "💡",
        -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
        hl_mode = "replace",
    },
    status_text = {
        enabled = false,
        -- Text to provide when code actions are available
        text = "💡",
        -- Text to provide when no actions are available
        text_unavailable = "",
    },
})

-- Modify the lightbulb sign:
--   Fill text, texthl, linehl, and numhl according to your preferences
vim.fn.sign_define("LightBulbSign", {
    text = "",
    texthl = "",
    linehl = "",
    numhl = "",
})

-- Modify the lightbulb float window and virtual text colors
--   Fill ctermfg, ctermbg, guifg, guibg according to your preferences
-- VimScript
-- vim.cmd([[
-- augroup HighlightOverride
--   autocmd!
--   au ColorScheme * highlight LightBulbFloatWin ctermfg= ctermbg= guifg= guibg=
--   au ColorScheme * highlight LightBulbVirtualText ctermfg= ctermbg= guifg= guibg=
-- augroup END
-- ]])
-- Lua
vim.api.nvim_command("highlight LightBulbFloatWin ctermfg=0 ctermbg=251 guifg=#242424 guibg=#cdcdcd")
vim.api.nvim_command("highlight LightBulbVirtualText ctermfg=239 ctermbg=251 guifg=#666666 guibg=#cdcdcd")

-- Status-line text usage
require("nvim-lightbulb").get_status_text()
