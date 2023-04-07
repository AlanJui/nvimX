local tabline = _G.safe_require("tabline")
if not tabline then
    return
end

tabline.setup({
    enable = false,
})
