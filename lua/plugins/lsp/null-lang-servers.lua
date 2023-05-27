-- null-ls: formatters
return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        -- JSON
        nls.builtins.diagnostics.jsonlint,
        nls.builtins.formatting.fixjson,
        -- YAML
        nls.builtins.diagnostics.yamllint,
        nls.builtins.formatting.jq,
        -- Lua Script
        nls.builtins.formatting.stylua,
        -- Shell / ZSH
        nls.builtins.diagnostics.zsh,
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.formatting.shfmt,
        -- Python
        -- nls.builtins.diagnostics.pylint.with({
        -- extra_args = { "--load-plugins", "pylint_django" },
        -- init_options = {
        --     "init-hook='import sys; import os; from pylint.config import find_pylintrc; sys.path.append(os.path.dirname(find_pylintrc()))'",
        -- },
        -- }),
        nls.builtins.diagnostics.flake8,
        nls.builtins.diagnostics.pylint,
        nls.builtins.diagnostics.pydocstyle.with({
          extra_args = { "--config=$ROOT/setup.cfg" },
        }),
        nls.builtins.diagnostics.mypy.with({
          extra_args = { "--config-file", "pyproject.toml" },
        }),
        -- nls.builtins.formatting.black,
        nls.builtins.formatting.autopep8,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.djhtml,
        nls.builtins.formatting.djlint,
        -- Markdown
        nls.builtins.formatting.markdown_toc,
        nls.builtins.formatting.markdownlint,
        -- Web Tools
        -- nls.builtins.formatting.eslint,
        nls.builtins.diagnostics.stylelint,
        nls.builtins.formatting.prettier.with({
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
      },
    }
  end,
}
