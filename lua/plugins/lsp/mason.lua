return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapInstall", "DapUninstall" },
      },
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
  },
}
