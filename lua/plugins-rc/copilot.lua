-------------------------------------------------------------------------------
-- Disabling all file types can be done by setting the
-- special key "*".  File types can then be turned back
-- on individually.
-------------------------------------------------------------------------------
local ok = pcall(require, "copilot")
if not ok then return end

-- 禁用內部文件類型限制
-- vim.g.copilot_internal_filetypes = {}

-- use this table to disable/enable filetypes
-- 正向表列：每種程式語語，均需 Copilot 協助；不需使用之程式語言，則一一條列。
vim.g.copilot_filetypes = {
  xml = false,
  markdown = true,
}
--
-- since most are enabled by default you can turn them off
-- using this table and only enable for a few filetypes
-- vim.g.copilot_filetypes = { ["*"] = false, python = true }
-- 逆向表列：基本上都不用 Copilot ；有需要使用的程式語言，則一一條列。
-- vim.g.copilot_filetypes = {
-- 	["*"] = false,
-- 	python = true,
-- 	lua = true,
-- }

-------------------------------------------------------------------------------
-- Default Keymap:
-- <Tab>/<Alt-l>  Accept the suggestion
-- <Ctrl-]>	      Dismiss the current suggestion
-- <Alt-[>	      Cycle to the next suggestion
-- <Alt-]>	      Cycle to the previous suggestionk
-- <C-]>          Dismiss the current suggestion.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Lua Script Configuration
-------------------------------------------------------------------------------
-- -- Disable Tab Key
-- vim.g.copilot_no_tab_map = true
-- -- Syntax Highlighting
-- vim.cmd([[highlight CopilotSuggestion guifg=#555557 ctermfg=8]])
-- vim.keymap.set_keymap("i", "<M-l>", function() copilot#Accept() end, { silent = true })
-- vim.api.nvim_set_keymap("i", "<M-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

-------------------------------------------------------------------------------
-- Vim Script Configuration
-------------------------------------------------------------------------------
vim.cmd([[

" Keymap
imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
imap <silent> <C-d> <Plug>(copilot-dismiss)
imap <silent> <C-]> <Plug>(copilot-next)
imap <silent> <C-[> <Plug>(copilot-previous)
imap <silent> <C-s> <Plug>(copilot-suggest)

" Syntax Highlighting
highlight CopilotSuggestion guifg=#555557 ctermfg=8
]])
