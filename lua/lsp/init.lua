local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup({
  ui = {
    check_outdated_packages_on_open = false,
    border = "single",
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

mason_lspconfig.setup({
  ensuer_installed = {
    -- Shell Script
    "bashls",
    -- Lua Script
    "lua_ls",
    -- Python
    "pyright",
    -- Web: HTML, CSS, JavaScript
    "cssls",
    "emmet_ls",
    "html",
    "jsonls",
    "tsserver",
    -- Markdown
    "marksman",
    -- configuration
    "taplo", -- TOML
    "yamlls",
    "lemminx", -- XML
    -- Others
    "julials",
  },
})

local function setup_language_servers()
  -- 無需透過 mason_lspconfig 進行 LSP 自動設定的語言伺服器
  local disabled_servers = { "texlab" }

  mason_lspconfig.setup_handlers({
    function(server_name)
      for _, name in pairs(disabled_servers) do
        if name == server_name then
          return
        end
      end
      local opts = {
        on_attach = require("lsp.handlers").on_attach,
        capabilities = require("lsp.handlers").capabilities,
      }

      local require_ok, lsp_settings = pcall(require, "lsp.settings." .. server_name)
      if require_ok then
        opts = vim.tbl_deep_extend("force", lsp_settings, opts)
      end

      lspconfig[server_name].setup(opts)
    end,
    ["texlab"] = function()
      local opts = {
        on_attach = require("lsp.handlers").on_attach,
        capabilities = require("lsp.handlers").capabilities,
      }
      local lsp_settings = require("lsp.settings.texlab")
      opts = vim.tbl_deep_extend("force", lsp_settings, opts)
      lspconfig.texlab.setup({})
    end,
  })

  -- 設定 nvim-ufo
  require("plugins-rc.nvim-ufo")
end

-- 令語言伺服器支援「自動補全輸入（Autocompletion）」及「片語（Snippets）」
-- Add additional capabilities supported by nvim-cmp
local function setup_auto_completion()
  ---@diagnostic disable-next-line: different-requires
  require("plugins-rc.copilot")
  require("lsp.autocmp")
end

---@diagnostic disable-next-line: unused-local, unused-function
local function setup_keymapping()
  -- 設定語言伺服器通用按鍵
  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

  -- 設定語言伺服器專屬按鍵
  -- Use LspAttach autocommand to only map the following keys after the language server attaches to the current buffer
  -- 當「語言服務器」連上當前緩衝區後，使用 LspAttach 自動命令，設定以下按鍵
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end,
  })
end

----------------------------------------------------------------

setup_language_servers()

setup_auto_completion()

-- setup_keymapping()

require("lsp.null-ls")
