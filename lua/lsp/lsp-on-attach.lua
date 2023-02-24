local M = {}

local on_attach = function(client, bufnr)
    local keymap = vim.keymap -- for conciseness
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)

    -- Sync Formatting
    local augroup = _G.LspFormattingAugroup
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

function M.key_bindings()
    return on_attach
end

return M
