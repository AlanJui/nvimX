local neogit = safe_require 'neogit'
if not neogit then
    return
end

neogit.setup {
    disable_signs = false,
    disable_context_highlighting = false,
    -- Disablint commit confirmation
    disable_commit_confirmation = true,
    -- customize displayed signs
    signs = {
        -- { CLOSED, OPENED }
        section = { '>', 'v' },
        item = { '>', 'v' },
        hunk = { '', '' },
    },
    integrations = { diffview = true },
}

-- Notification Highlighting
vim.cmd [[
hi NeogitNotificationInfo guifg=#80ff95
hi NeogitNotificationWarning guifg=#fff454
hi NeogitNotificationError guifg=#c44323
]]

-- Contextual Highlighting
vim.cmd [[
hi def NeogitDiffAddHighlight guibg=#404040 guifg=#859900
hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f
hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2
hi def NeogitHunkHeader guifg=#cccccc guibg=#404040
hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d
]]
