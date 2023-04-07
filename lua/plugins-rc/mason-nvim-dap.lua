local ok, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not ok then
    return
end

-- 務必確認以下的設定指令，須依如下順序執行
-- require("mason").setup(...)
-- require("mason-nvim-dap").setup(...),
mason_nvim_dap.setup({
    ensure_installed = {
        "python",
        "node2",
        "jq",
    },
})
