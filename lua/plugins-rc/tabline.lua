local tabline = safe_require('tabline')
if not tabline then
    return
end

tabline.setup({
    enable = false
})
