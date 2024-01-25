return {
  "williamboman/mason.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    local mason_list = {
      "lua-language-server", -- Lua LSP Server
      "stylua",
      "rust-analyzer", -- Rust LSP Server
      -- "pyright", -- Python LSP Server
      -- "python-lsp-server", -- Python LSP Server
      "ruff-lsp", -- Python LSP Server
      "debugpy", -- python
      "ruff", -- Linter
      "pylint", -- Linter
      "isort", -- Formatter
      "black", -- Formatter
      "mypy", -- Type checker
      "typescript-language-server", -- JavaScript LSP Server
      "vue-language-server",
      "js-debug-adapter", -- Javascript DAP
      "emmet-ls",
      "html-lsp",
      "css-lsp",
      "tailwindcss-language-server",
      "eslint_d", -- JavaScript Linter
      "prettier", -- Formatter
      "json-lsp",
      "lemminx", -- XML LSP Server
      "yaml-language-server",
      "taplo", -- TOML Lsp Server
      "marksman", -- Markdown LSP Server
      "dockerfile-language-server", -- Docker LSP Server
      "clang-format", -- Formatter
    }

    -- enable mason and configure icons
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      -- ensure_installed = mason_list,
    })

    -- Install all bianries that mason supported
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      if mason_list and #mason_list > 0 then
        vim.cmd("MasonInstall " .. table.concat(mason_list, " "))
      end
    end, {})
  end,
}
