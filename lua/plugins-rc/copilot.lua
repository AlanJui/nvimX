-------------------------------------------------------------------------------
-- Disabling all file types can be done by setting the
-- special key "*".  File types can then be turned back
-- on individually.
-------------------------------------------------------------------------------
local ok = pcall(require, "copilot")
if not ok then return end

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
-- <Tab>        Accept the suggestion
-- <Ctrl-]>	    Dismiss the current suggestion
-- <Alt-[>	    Cycle to the next suggestion
-- <Alt-]>	    Cycle to the previous suggestionk
-- <C-]>                   Dismiss the current suggestion.
--
-- <C-]>                   Dismiss the current suggestion.
-- <Plug>(copilot-dismiss)
--
--                                                 *copilot-i_ALT-]*
-- <M-]>                   Cycle to the next suggestion, if one is available.
-- <Plug>(copilot-next)
--
--                                                 *copilot-i_ALT-[*
-- <M-[>                   Cycle to the previous suggestion.
-- <Plug>(copilot-previous)
-------------------------------------------------------------------------------

-- Keymap
-- vim.g.copilot_no_tab_map = true
vim.g.copilot_no_tab_map = false
-- Syntax Highlighting
vim.cmd([[highlight CopilotSuggestion guifg=#555557 ctermfg=8]])
-- vim.keymap.set.keymap("i", "<C-y>", ":copilot#Accept('\\<CR>')<CR>", { silent = true })
-- vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- vim.cmd([[
-- let g:copilot_no_tab_map = v:true
-- " Keymap
-- imap <silent><script><expr> <C-y> copilot#Accept("\<CR>")
-- imap <silent> <C-]> <Plug>(copilot-dismiss)
-- imap <silent> <M-]> <Plug>(copilot-next)
-- imap <silent> <M-[> <Plug>(copilot-previous)
-- imap <silent> <M-\> <Plug>(copilot-suggest)
--
-- " Syntax Highlighting
-- highlight CopilotSuggestion guifg=#555557 ctermfg=8
-- ]])
