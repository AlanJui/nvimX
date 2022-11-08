--------------------------------------------------------------------------
-- null-ls: https://github.com/jose-elias-alvarez/null-ls.nvim
-- Use Neovim as a language server to inject LSP diagnostics, code actions,
-- and more via Lua.
--------------------------------------------------------------------------
local null_ls = safe_require("null-ls")
if not null_ls then
	return
end

-- register any number of sources simultaneously
null_ls.setup({
    sources = {
        -- Built-in sources have access to a special method, with(),
        -- which modifies a subset of the source's default options.
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "html", "css", "scss", "less", "javascript", "typescript", "vue", "json", "jsonc", "yaml", "markdown", "handlebars" },
            extra_filetypes = { "json" },
        }),
        -- Snippet engine for Neovim
        -- null_ls.builtins.completion.luasnip,
        ---------------------------------------------------------------
        -- Python
        ---------------------------------------------------------------
        -- Pylint is a Python static code analysis tool which looks for
        -- programming errors, helps enforcing a coding standard, sniffs
        -- for code smells and offers simple refactoring suggestions.
        null_ls.builtins.diagnostics.pylint,
        -- -- pydocstyle is a static analysis tool for checking compliance
        -- -- with Python docstring conventions.
        -- null_ls.builtins.diagnostics.pydocstyle,
        -- flake8 is a python tool that glues together pycodestyle,
        -- pyflakes, mccabe, and third-party plugins to check the style
        -- and quality of Python code.
        null_ls.builtins.diagnostics.flake8,
        -- A tool that automatically formats Python code to conform to
        -- the PEP 8 style guide.
        null_ls.builtins.formatting.autopep8,
        -- The uncompromising Python code formatter
        -- null_ls.builtins.formatting.black.with({
        -- 	filetypes = { "python" },
        -- 	command = "black",
        -- 	extra_args = { "--stdin-filename", "$FILENAME", "--quiet", "-" },
        -- }),
        -- Python utility / library to sort imports alphabetically and
        -- automatically separate them into sections and by type.
        null_ls.builtins.formatting.isort,
        -- Django HTML Template Linter and Formatter.
        null_ls.builtins.diagnostics.djlint,
        null_ls.builtins.formatting.djlint,
        -- A pure-Python Django/Jinja template indenter without dependencies.
        null_ls.builtins.formatting.djhtml,
        ---------------------------------------------------------------
        -- Lua
        ---------------------------------------------------------------
        -- Snippet engine for Neovim, written in Lua.
        -- null_ls.builtins.completion.luasnip,
        -- for linting and static analysis of Lua code
        -- null_ls.builtins.diagnostics.luacheck,
        -- Reformats your Lua source code.
        null_ls.builtins.formatting.lua_format,
        ---------------------------------------------------------------
        -- Web
        ---------------------------------------------------------------
        -- Tags completion source.
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.completion.tags,
        -- null_ls.builtins.completion.spell,
        -- Find and fix problems in your JavaScript code.
        null_ls.builtins.formatting.eslint,
        ---------------------------------------------------------------
        -- Markdown style and syntax checker
        null_ls.builtins.diagnostics.markdownlint,
        -- A Node.js style checker and lint tool for Markdown/CommonMark
        -- files.
        null_ls.builtins.formatting.markdownlint
        -- A linter for YAML files
        -- null_ls.builtins.diagnostics.zsh,
    }
})
