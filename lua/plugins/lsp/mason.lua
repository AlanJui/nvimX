return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_null_ls = require("mason-null-ls")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "pyright",
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        "emmet_ls",
        -- "graphql",
        -- "prismals",
        -- "svelte",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_null_ls.setup({
      ensure_installed = {
        -- Lua Script
        "stylua", -- lua formatter
        -- Python Script
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "ruff", -- python linter
        "mypy", -- python linter
        -- JavaScript Script
        "prettier", -- prettier formatter
        "eslint_d", -- js linter
      },
      automatic_installation = true,
    })
  end,
}
