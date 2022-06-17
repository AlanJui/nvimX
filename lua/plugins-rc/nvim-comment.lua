-- Plugin configuration: nvim-comment
local nvim_comment = safe_require('nvim_comment')
if not nvim_comment then
    return
end

nvim_comment.setup()
