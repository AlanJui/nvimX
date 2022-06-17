-----------------------------------------------------------
-- Color Themes
-----------------------------------------------------------
local color_scheme_installed = safe_require('tokyonight')


if not color_scheme_installed then
    vim.cmd [[
        try
            colorscheme solarized8_flat
            " colorscheme solarized8
            " colorscheme OceanicNext
            " colorscheme rvcs
            " colorscheme nightfly
            " colorscheme moonfly
        catch
            colorscheme gruvbox
        endtry
    ]]
else
    -- Tokyo Night Color Scheme Configuration
    -- vim.g.tokyonight_style = 'day'
    -- vim.g.tokyonight_style = 'night'
    vim.cmd([[ colorscheme tokyonight ]])
    vim.g.tokyonight_style = 'storm'
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_dark_float = true
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_sidebars = {
        'qf',
        'vista_kind',
        'terminal',
        'packer',
    }
    -- Change the "hint" color to the "orange" color,
    -- and make the "error" color bright red
    vim.g.tokyonight_colors = {
        hint = 'orange',
        error = '#ff0000'
    }
end
