if not _G.safe_require("ufo") then
    return
end

require("ufo").setup({
    ---@diagnostic disable-next-line: unused-local
    provider_selector = function(bufnr, filetype, buftype) -- luacheck: ignore
        return { "treesitter", "indent" }
    end,
})
