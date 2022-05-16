-- Set themes
-- vim.cmd([[ colorscheme solarized8_flat ]])
-- vim.g.colors_name = 'molokai'

---------------------------------------------
-- Tokyo Night Color Scheme Configuration
---------------------------------------------
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
