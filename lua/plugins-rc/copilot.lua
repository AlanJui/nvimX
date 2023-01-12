-- Disabling all file types can be done by setting the
-- special key "*".  File types can then be turned back
-- on individually.

vim.cmd([[
let g:copilot_filetypes = {
        \ '*': v:false,
        \ 'python': v:true,
        \ }
]])

-- If you'd rather use a key that isn't <Tab>, define an <expr> map that calls
-- copilot#Accept().  Here's an example with CTRL-J:
vim.cmd([[
        imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
        let g:copilot_no_tab_map = v:true
]])

-------------------------------------------------------------------------------
-- Default Keymap:
-- <Tab>        ccept the suggestion
-- <Ctrl-]>	    Dismiss the current suggestion
-- <Alt-[>	    Cycle to the next suggestion
-- <Alt-]>	    Cycle to the previous suggestionk
-------------------------------------------------------------------------------
