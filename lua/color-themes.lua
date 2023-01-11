-----------------------------------------------------------
-- Color Themes
-----------------------------------------------------------
-- set colorscheme to nightfly with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme nightfly")

local function myColorScheme(color)
	local color = color or "tokyonight"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- 若是已安裝 nightfly colorscheme ，直接採用
if status then
	-- vim.cmd([[ colorscheme nightfly ]])
	myColorScheme("nightfly")
else
	-- 若尚未安裝該擴充套件，告知使用者。
	print("Colorscheme of Nightfly not found!") -- print error if colorscheme not installed

	-- 判斷是否可套用 TokyoNight Colorscheme
	local tokyonight_status, _ = pcall(vim.cmd, "colorscheme tokyonight")
	if not tokyonight_status then
		-- 若 TokyoNight 亦尚未安裝，則改用預設 Solarized8_flat Colorscheme
		print("Colorscheme of TokyoNight not found!") -- print error if colorscheme not installed

		-- use default colorscheme
		-- vim.cmd([[ colorscheme solarized8_flat ]])
		vim.cmd.colorscheme("solarized8_flat")
		return
	else
		-- Tokyo Night Color Scheme Configuration
		-- vim.g.tokyonight_style = 'day'
		-- vim.g.tokyonight_style = 'night'
		-- vim.cmd([[ colorscheme tokyonight ]])
		vim.cmd.colorscheme("tokyonight")
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
