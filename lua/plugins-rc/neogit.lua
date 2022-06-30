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

