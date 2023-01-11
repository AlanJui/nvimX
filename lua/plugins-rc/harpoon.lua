if not pcall(require, "harpoon") then
	return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- 以下的 <localleader> 設定不可少
vim.g.maplocalleader = ","
vim.keymap.set("n", "<localleader>a", mark.add_file)
vim.keymap.set("n", "<localleader>e", ui.toggle_quick_menu)

vim.keymap.set("n", "<localleader>1", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<localleader>2", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<localleader>3", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<localleader>4", function()
	ui.nav_file(4)
end)
