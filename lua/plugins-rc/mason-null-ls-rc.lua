local mason_null_ls = _G.safe_require("mason-null-ls")
local null_ls = _G.safe_require("null-ls")

if not mason_null_ls or not null_ls then
    return
end

-- register any number of sources simultaneously
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local completion = null_ls.builtins.completion
local code_actions = null_ls.builtins.code_actions

local sources = {
    -- Built-in sources have access to a special method, with(),
    -- which modifies a subset of the source's default options.
    code_actions.gitsigns,
    ---------------------------------------------------------------
    -- Lua
    ---------------------------------------------------------------
    -- Snippet engine for Neovim, written in Lua.
    completion.luasnip,
    -- for linting and static analysis of Lua code
    diagnostics.luacheck,
    -- Reformats your Lua source code.
    -- formatting.lua_format,
    formatting.stylua,
    ---------------------------------------------------------------
    -- Web
    ---------------------------------------------------------------
    -- Tags completion source.
    diagnostics.eslint, -- null_ls.builtins.completion.tags,
    -- null_ls.builtins.completion.spell,
    -- Find and fix problems in your JavaScript code.
    -- formatting.eslint,
    formatting.prettier.with({
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
    }),
    ---------------------------------------------------------------
    -- Python/Django
    ---------------------------------------------------------------
    -- Pylint is a Python static code analysis tool which looks for
    -- programming errors, helps enforcing a coding standard, sniffs
    -- for code smells and offers simple refactoring suggestions.
    -- diagnostics.pylint.with({
    -- 	diagnostics_postprocess = function(diagnostic)
    -- 		diagnostic.code = diagnostic.message_id
    -- 	end,
    -- }),
    formatting.isort,
    formatting.autopep8,
    -- formatting.black,
    -- A pure-Python Django/Jinja template indenter without dependencies.
    formatting.djhtml,
    formatting.djlint,

    -- mypy is an optional static type checker for Python that aims to
    -- combine the benefits fo dynamic (or "dock") typing and static typings.
    -- diagnostics.mypy,

    -- pydocstyle is a static analysis tool for checking compliance
    -- with Python docstring conventions.
    -- diagnostics.pydocstyle,

    -- flake8 is a python tool that glues together pycodestyle,
    -- pyflakes, mccabe, and third-party plugins to check the style
    -- and quality of Python code.
    diagnostics.flake8,

    -- A tool that automatically formats Python code to conform to
    -- the PEP 8 style guide.
    -- Django HTML Template Linter and Formatter.
    diagnostics.djlint,
    ---------------------------------------------------------------
    -- Markdown style and syntax checker
    diagnostics.markdownlint,
    -- A Node.js style checker and lint tool for Markdown/CommonMark
    -- files.
    formatting.markdownlint,
    -- A linter for YAML files
    diagnostics.zsh,
}

mason_null_ls.setup({
    ensure_installed = {
        -- Opt to list sources here, when available in mason.
        "stylua",
        "jq",
    },
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
})

-- If `automatic_setup` is true.
-- mason_null_ls.setup_handers()
require('mason-null-ls').setup_handers({
    function(source_name, methods)
        -- all sources with no handler get passed here

        -- To keep the original functionality of `automatic_setup = true`,
        -- please add the below.
        require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    stylua = function(source_name, methods) -- luacheck: ignore
        null_ls.register(null_ls.builtins.formatting.stylua)
    end,
})
--
-- will setup any installed and configured sources above
null_ls.setup()
-- null_ls.setup({
-- 	sources = sources,
-- })
