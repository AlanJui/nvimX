return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
      "jay-babu/mason-nvim-dap.nvim",
      cmd = { "DapInstall", "DapUninstall" },
    },
  },
  config = function()
    -- enable mason and configure icons
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "pyright",
        -- "pylsp",
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

    -- Linters and Formatters
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- lua stuff
        "stylua",
        -- web dev stuff
        "prettier", -- Formatter
        "eslint_d", -- JavaScript Linter
        -- c/cpp stuff
        "clang-format", -- Formatter
        -- Python
        "isort", -- Formatter
        "black", -- Formatter
        "pylint", -- Linter
        "ruff", -- Linter
        "mypy", -- Type checker
      },
    })

    -- Debuggers
    require("mason-nvim-dap").setup({
      -- A list of adapters to install if they're not already installed.
      -- This setting has no relation with the `automatic_installation` setting.
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "python",
        "js",
        "node2",
      },

      -- NOTE: this is left here for future porting in case needed
      -- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Daps are not automatically installed.
      --   - true: All adapters set up via dap are automatically installed.
      --   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "python", "delve" } }
      automatic_installation = true,

      -- See below on usage
      handlers = nil,
    })
  end,
}
