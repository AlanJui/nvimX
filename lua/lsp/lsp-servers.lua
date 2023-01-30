-----------------------------------------------------------
-- (1) Setup mason
-- (2) Setup mason-lspconfig
-- (3) Setup mason-null-ls
-- (4) Enable UI for LSP (lspsaga)
-- (5) Setup servers via lspconfig
-----------------------------------------------------------
-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
    return
end

local nvim_config = GetConfig()

-----------------------------------------------------------
-- (1) Setup mason
-----------------------------------------------------------
mason.setup({
    install_root_dir = nvim_config["runtime"] .. "/mason",
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },
})

-----------------------------------------------------------
-- (2) Setup mason-lspconfig
-----------------------------------------------------------
mason_lspconfig.setup({
    -- list of servers for mason to install
    ensure_installed = nvim_config["lsp_servers"],
    -- auto-install configured servers (with lspconfig)
    automatic_installation = true,
})

-----------------------------------------------------------
-- (3) Setup mason-null-ls
-----------------------------------------------------------
mason_null_ls.setup({
    -- list of formatters & linters for mason to install
    ensure_installed = {
        "prettier", -- ts/js formatter
        "stylua", -- lua formatter
        "eslint_d", -- ts/js linter
    },
    -- auto-install configured formatters & linters (with null-ls)
    automatic_installation = true,
})

-----------------------------------------------------------
-- (4) Enable UI for LSP (lspsaga)
-----------------------------------------------------------

-- -- import lspsaga safely
-- local saga_status, saga = pcall(require, "lspsaga")
-- if not saga_status then
-- 	return
-- end
--
-- saga.init_lsp_saga({
-- 	-- keybinds for navigation in lspsaga window
-- 	move_in_saga = { prev = "<C-k>", next = "<C-j>" },
-- 	-- use enter to open file with finder
-- 	finder_action_keys = { open = "<CR>" },
-- 	-- use enter to open file with definition preview
-- 	definition_action_keys = { edit = "<CR>" },
-- })

-----------------------------------------------------------
-- (5) Setup servers via lspconfig
-----------------------------------------------------------

-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
    return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
    return
end

---
-- Keybindings
---

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
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

    -- -- typescript specific keymaps (e.g. rename file and update imports)
    -- if client.name == "tsserver" then
    -- 	keymap.set("n", "<localleader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
    -- 	keymap.set("n", "<localleader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    -- 	keymap.set("n", "<localleader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
    -- end
end

---
-- Diagnostics
---

local sign = function(opts)
    vim.fn.sign_define(opts.name, { texthl = opts.name, text = opts.text, numhl = "" })
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = " " })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = { border = "rounded", source = "always", header = "", prefix = "" },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

---
-- Enable autocompletion
---
local capabilities = cmp_nvim_lsp.default_capabilities()
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
    "force",
    lsp_defaults.capabilities,
    -- Add additional capabliities supported by nvim-cmp
    capabilities
)

--
-- Others
--
local lsp_flags = { debounce_text_changes = 150 }

-----------------------------------------------------------------------------------------------
-- Regsister LSP servers setup handlers
-----------------------------------------------------------------------------------------------

require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            flags = lsp_flags,
        })
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            flags = lsp_flags,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = { globals = { "vim" } },
                    -- workspace = {
                    -- 	-- make language server aware of runtime files
                    -- 	library = {
                    -- 		[vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    -- 		[vim.fn.stdpath("config") .. "/lua"] = true,
                    -- 	},
                    -- },
                },
            },
        })
    end,
    ["pyright"] = function()
        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            flags = lsp_flags,
            cmd = { "pyright-langserver", "--stdio" },
            -- root_dir = function()
            -- 	return vim.loop.cwd()
            -- end,
            filetypes = { "python" },
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "off",
                        logLevel = "Error",
                    },
                    -- linting = {
                    -- 	pylintArgs = {
                    -- 		"--load-plugins=pylint_django",
                    -- 		"--load-plugins=pylint_dango.checkers.migrations",
                    -- 		"--errors-only",
                    -- 	},
                    -- },
                },
            },
            single_file_support = true,
        })
    end,
    -- configure emmet language server
    ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            flags = lsp_flags,
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
            },
        })
    end,
    ["jsonls"] = function()
        lspconfig.jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            flags = lsp_flags,
            filetypes = { "json", "jsonc" },
            settings = { json = { schemas = require("lsp/json-schemas") } },
            setup = {
                commands = {
                    Format = {
                        function()
                            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
                        end,
                    },
                },
            },
            init_options = { provideFormatter = true },
            single_file_support = true,
        })
    end,
})
