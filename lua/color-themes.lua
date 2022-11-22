-----------------------------------------------------------
-- Color Themes
-----------------------------------------------------------
-- set colorscheme to nightfly with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme nightfly")

if status then
	vim.cmd([[ colorscheme nightfly ]])
else
	print("Colorscheme of Nightfly not found!") -- print error if colorscheme not installed

	local tokyonight_status, _ = pcall(vim.cmd, "colorscheme tokyonight")
	if not tokyonight_status then
		print("Colorscheme of TokyoNight not found!") -- print error if colorscheme not installed

		-- use default colorscheme
		vim.cmd([[ colorscheme solarized8_flat ]])
		return
	else
		-- Tokyo Night Color Scheme Configuration
		-- vim.g.tokyonight_style = 'day'
		-- vim.g.tokyonight_style = 'night'
		vim.cmd([[ colorscheme tokyonight ]])
		vim.g.tokyonight_style = "storm"
		vim.g.tokyonight_italic_functions = true
		vim.g.tokyonight_dark_float = true
		vim.g.tokyonight_transparent = true
		vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
		-- Change the "hint" color to the "orange" color,
		-- and make the "error" color bright red
		vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
	end
end
