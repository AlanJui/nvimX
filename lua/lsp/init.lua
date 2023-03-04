local lspconfig = _G.safe_require("lspconfig")
local mason = _G.safe_require("mason")
local mason_lspconfig = _G.safe_require("mason-lspconfig")
local mason_tool_installer = _G.safe_require("mason-tool-installer")
local cmp = _G.safe_require("cmp")
local luasnip = _G.safe_require("luasnip")
local lspkind = _G.safe_require("lspkind")

if not lspconfig or not mason or not mason_lspconfig or not mason_tool_installer then return end

if not cmp or not luasnip or not lspkind then return end

------------------------------------------------------------------------
-- Variables for this Module
------------------------------------------------------------------------
_G.LspFormattingAugroup = vim.api.nvim_create_augroup("LspFormatting", {})

local nvim_config = _G.GetConfig()

------------------------------------------------------------------------
-- Automatic LSP Setup
------------------------------------------------------------------------
local function setup_lsp_auto_installation()
    --
    -- Mason: Easily install and manage LSP servers, DAP servers, linters, and formatters.
    --
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

    -- `mason-lspconfig` provides extra, opt-in, functionality that allows you to
    -- automatically set up LSP servers installed via `mason.nvim` without having to
    -- manually add each server setup to your Neovim configuration. It also makes it
    -- possible to use newly installed servers without having to restart Neovim!
    require("mason-lspconfig").setup({
        ensure_installed = nvim_config["lsp_servers"],
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true,
    })

    ------------------------------------------------------------
    -- 透過 mason-tool-installer 自動安裝 Null-LS, DAP ；
    -- 且自動更新所有的 LS 及 Null-LS
    ------------------------------------------------------------
    -- local ensure_installed_list = {
    --     -- Lua
    --     "lua-language-server",
    --     "vim-language-server",
    --     "diagnostic-languageserver",
    --     "stylua",
    --     -- luacheck: ignore
    --     -- Python
    --     "pyright",
    --     "pylint",
    --     "pydocstyle",
    --     "flake8",
    --     "djlint",
    --     "isort",
    --     "autopep8",
    --     "black",
    --     "debugpy",
    --     -- Web
    --     "html-lsp",
    --     "css-lsp",
    --     "tailwindcss-language-server",
    --     "stylelint-lsp",
    --     "emmet-ls",
    --     "prettier",
    --     -- JavaScript
    --     "typescript-language-server",
    --     "json-lsp",
    --     "eslint-lsp",
    --     "js-debug-adapter",
    --     "node-debug2-adapter",
    --     -- Others
    --     "yamllint",
    --     "yamlfmt",
    --     "bash-debug-adapter",
    --     "bash-language-server",
    --     "shellcheck",
    --     "jq",
    --     "markdownlint",
    --     "texlab",
    -- }
    ---@diagnostic disable-next-line: unused-local
    local ensure_installed_list = {
        "lua-language-server",
        "diagnostic-languageserver",
        "pyright",
        "autopep8",
        "black",
        "debugpy",
        "prettier",
        "typescript-language-server",
        "json-lsp",
        "eslint-lsp",
        "js-debug-adapter",
        "node-debug2-adapter",
    }

    require("mason-tool-installer").setup({
        -- a list of all tools you want to ensure are installed upon
        -- start; they should be the names Mason uses for each tool
        ensure_installed = ensure_installed_list,
        -- if set to true this will check each tool for updates. If updates
        -- are available the tool will be updated. This setting does not
        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = true,
        -- automatically install / update on startup. If set to false nothing
        -- will happen on startup. You can use :MasonToolsInstall or
        -- :MasonToolsUpdate to install tools and check for updates.
        -- Default: true
        run_on_start = true,
        -- set a delay (in ms) before the installation starts. This is only
        -- effective if run_on_start is set to true.
        -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
        -- Default: 0
        start_delay = 3000, -- 3 second delay
    })
end

------------------------------------------------------------------------
-- Setup configuration for every LSP
------------------------------------------------------------------------
local function setup_lsp()
    ------------------------------------------------------------------------
    -- Keybindings
    ------------------------------------------------------------------------
    -- local keymap = vim.keymap -- for conciseness
    --
    -- -- enable keybinds only for when lsp server available
    -- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- local opts = { noremap = true, silent = true }
    -- keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    -- keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
    --
    -- local lsp_attach = require("lsp/lsp-on-attach").key_bindings()

    --
    -- 使用 LSP Saga 代替 LSP Key Bindings
    --
    ---@diagnostic disable-next-line: unused-local
    local lsp_attach = function(client, bufnr) end -- luacheck: ignore

    ------------------------------------------------------------------------
    -- Setup lspconfig with setup_handlers of mason-ispconfig
    ------------------------------------------------------------------------
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
            lspconfig[server_name].setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
            })
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end,
        ["lua_ls"] = function()
            -- lspconfig.lua_ls.setup(
            --     require("lsp/settings/lua_ls").setup(lsp_attach, lsp_capabilities)
            -- )
            lspconfig.lua_ls.setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,
        ["emmet_ls"] = function()
            lspconfig.emmet_ls.setup({
                on_attach = lsp_attach,
                capabilities = lsp_capabilities,
                filetypes = {
                    "htmldjango",
                    "html",
                    "css",
                    "scss",
                    "typescriptreact",
                    "javascriptreact",
                },
            })
        end,
        ["pyright"] = function()
            lspconfig.pyright.setup(require("lsp/settings/pyright").setup(lsp_attach, lsp_capabilities))
        end,
        ["tsserver"] = function()
            lspconfig.tsserver.setup(require("lsp/settings/tsserver").setup(lsp_attach, lsp_capabilities))
        end,
        ["jsonls"] = function()
            lspconfig.jsonls.setup(require("lsp/settings/jsonls").setup(lsp_attach, lsp_capabilities))
        end,
        ["texlab"] = function()
            lspconfig.texlab.setup(require("lsp/settings/texlab").setup(lsp_attach, lsp_capabilities))
        end,
    })
end

------------------------------------------------------------
-- Setup Diagnostics
------------------------------------------------------------
local function setup_diagnostics()
    ---@diagnostic disable-next-line: redefined-local
    local sign = function(opts) -- luacheck: ignore
        vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = "",
        })
    end

    sign({ name = "DiagnosticSignError", text = "✘" })
    sign({ name = "DiagnosticSignWarn", text = " " })
    sign({ name = "DiagnosticSignHint", text = "" })
    sign({ name = "DiagnosticSignInfo", text = "" })

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

------------------------------------------------------------
-- Processes of Module
------------------------------------------------------------

-- (1) 設定 LSP 自動安裝機制 (Automatic LSP Setup)
setup_lsp_auto_installation()

-- (2) 設定 Auto Completion (Auto-cmp and snippets setup: cmp.nvim + luasnip)
require("lsp/lsp-autocmp")
-- require("lsp/lsp-autocmp-copilot")

-- (3) 設定 LSP (Setup configuration for every LSP)
setup_lsp()

-- (4) 設定 Null Languager Server (Null-LS Setup)
require("lsp/lsp-null-ls").setup()

-- (5) 設定 LSP Diagnostics (Setup Diagnostics)
setup_diagnostics()

-- (6) 設定 Lsp Saga
require("plugins-rc.lspsaga-nvim")
