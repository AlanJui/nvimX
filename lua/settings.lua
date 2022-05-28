-- Configurations of Neovim
vim.cmd [[
let g:tex_flavor = "latex"
]]
-- Folding Text
vim.cmd [[
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
]]
