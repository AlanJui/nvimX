local null_ls = _G.safe_require("null-ls")
local mason_null_ls = _G.safe_require("mason-null-ls")
if not null_ls or not mason_null_ls then return end

local M = {}

local lsp_format_augroup = _G.LspFormattingAugroup

local null_ls_on_attach = function(current_client, bufnr)
    -- to setup format on save
    if current_client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = lsp_format_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = lsp_format_augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    filter = function(client) -- luacheck: ignore
                        --  only use null-ls for formatting instead of lsp server
                        return client.name == "null-ls"
                    end,
                    bufnr = bufnr,
                })
            end,
        })
    end
end

--------------------------------------------------------------
-- Install Null-LS automatically
--------------------------------------------------------------
local ensure_installed_list = {
    -- Lua
    -- "luacheck",
    -- "stylua",
    -- Web
    "prettier",
    -- Python/Django
    "pylint",
    -- "mypy",
    "pydocstyle",
    -- "flake8",
    "isort",
    "djhtml",
    "djlint",
    -- "autopep8",
    -- Markdown
    "markdownlint",
    -- Shell
    "zsh",
    "shellcheck",
    -- Misc.
    "jq",
}

require("mason-null-ls").setup({
    ensure_installed = ensure_installed_list,
    automatic_installation = true,
    automatic_setup = true,
})

--
-- Required when `automatic_setup` is true
--
-- register any number of sources simultaneously
-- local formatting = null_ls.builtins.formatting -- to setup formatters
-- local diagnostics = null_ls.builtins.diagnostics -- to setup linters
-- local completion = null_ls.builtins.completion
-- local code_actions = null_ls.builtins.code_actions
-- local utils = require("null-ls.utils")

require("mason-null-ls").setup_handlers({
    function(source_name, methods)
        -- all sources with no handler get passed here

        -- To keep the original functionality of `automatic_setup = true`,
        -- please add the below.
        require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    ---@diagnostic disable-next-line: unused-local
    stylua = function(source_name, methods) -- luacheck: ignore
        null_ls.register(null_ls.builtins.formatting.stylua)
    end,
    ---@diagnostic disable-next-line: unused-local
    pylint = function(source_name, methods) -- luacheck: ignore
        null_ls.register(null_ls.builtins.diagnostics.pylint.with({
            command = "pylint",
            -- extra_args = { "--load-plugins", "pylint_django" },
            -- init_options = {
            --     "init-hook='import sys; import os; from pylint.config import find_pylintrc; sys.path.append(os.path.dirname(find_pylintrc()))'",
            -- },
        }))
    end,
    ---@diagnostic disable-next-line: unused-local
    pydocstyle = function(source_name, methods) -- luacheck: ignore
        null_ls.register(null_ls.builtins.diagnostics.pydocstyle.with({
            extra_args = { "--config=$ROOT/setup.cfg" },
        }))
    end,
    ---@diagnostic disable-next-line: unused-local
    mypy = function(source_name, methods)
        null_ls.register(null_ls.builtins.diagnostics.mypy.with({
            extra_args = { "--config-file", "pyproject.toml" },
            -- extra_args = { "--config-file", "mypy.ini" },
            -- extra_args = { "--config-file", "setup.cfg" },
            -- cwd = function(_) return vim.fn.getcwd() end,
            -- runtime_condition = function(params) return utils.path.exists(params.bufname) end,
        }))
    end,
    ---@diagnostic disable-next-line: unused-local
    prettier = function(source_name, methods)
        null_ls.register(null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "html",
                "css",
                "scss",
                "less",
                "javascript",
                "typescript",
                "vue",
                "json",
                "jsonc",
                "yaml",
                "markdown",
                "handlebars",
            },
            extra_filetypes = {},
        }))
    end,
})

--------------------------------------------------------------------
-- Functions for Module
--------------------------------------------------------------------
function M.setup()
    -- to setup format on save
    null_ls.setup({
        on_attach = null_ls_on_attach,
    })
end

return M
