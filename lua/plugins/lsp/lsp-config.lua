return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    ---------------------------------------------------------------------
    -- Configure LSP servers with default configration
    ---------------------------------------------------------------------
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true }

    local servers = {
      "cssls", -- css-lsp
      "tailwindcss", -- tailwindcss-lsp
      "eslint", -- eslint-lsp
      "taplo", -- toml-lsp
      "dockerls", -- docker-lsp
    }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        capabilities = capabilities,
      })
    end

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = {
            globals = { "vim", "hs" },
          },
        },
      },
    })

    -- configure python server with plugin
    lspconfig["pylsp"].setup({
      capabilities = capabilities,
      settings = {
        pylsp = {
          pycodestyle = {
            ignore = { "W391" },
            maxLineLength = 100,
          },
        },
      },
    })

    -- configure typescript server with plugin
    lspconfig["tsserver"].setup({
      capabilities = capabilities,
    })

    -- configure vue server with plugin
    lspconfig["vuels"].setup({
      capabilities = capabilities,
    })

    -- configure emmet language server
    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      filetypes = {
        "html",
        "htmldjango",
        "typescriptreact",
        "javascriptreact",
        "vue",
        "css",
        "sass",
        "scss",
        "less",
        "svelte",
      },
    })

    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      filetypes = {
        "html",
        "htmldjango",
      },
    })

    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
    })

    -- configure tailwindcss server
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
    })

    -- configure json server
    lspconfig["jsonls"].setup({
      capabilities = capabilities,
      filetypes = {
        "json",
        "jsonc",
      },
    })

    -- configure xml server
    lspconfig["lemminx"].setup({
      capabilities = capabilities,
      filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
    })

    -- configure yaml server
    lspconfig["yamlls"].setup({
      capabilities = capabilities,
      filetypes = {
        "yaml",
        "yaml.docker-compose",
      },
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            -- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
            -- ["/path/from/root/of/project"] = "/.github/workflows/*",
          },
        },
      },
    })

    -- configure markdown server
    lspconfig["marksman"].setup({
      capabilities = capabilities,
      filetypes = {
        "markdown",
        "markdown.mdx",
      },
    })

    lspconfig["textlsp"].setup({
      capabilities = capabilities,
      settings = require("plugins.lsp.configs.texlab"),
    })

    -- configure rust server with plugin
    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = false,
          },
        },
      },
    })

    -- lspconfig["ruff_lsp"].setup({
    --   capabilities = capabilities,
    --   init_options = {
    --     settings = {
    --       -- Any extra CLI arguments for `ruff` go here.
    --       args = {},
    --     },
    --   },
    -- })

    -- configure python server
    -- lspconfig["pyright"].setup({
    --   capabilities = capabilities,
    -- })

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    opts.desc = "Show floating diagnostics"
    keymap.set("n", "<leader>cX", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>cx", vim.diagnostic.setloclist, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        opts.desc = "Go to declaration"
        keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "<leader>cd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "<leader>cft", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "<leader>cfi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP references"
        keymap.set("n", "<leader>cfr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Show signature help"
        keymap.set("n", "<leader>ck", function()
          vim.lsp.buf.signature_help()
        end, opts) -- show documentation for what is under cursor

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>cR", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "See available code actions"
        vim.keymap.set("n", "<leader>cf", function()
          -- vim.lsp.buf.format()
          vim.lsp.buf.format({ async = true })
        end, opts)

        opts.desc = "List workspace folders"
        vim.keymap.set("n", "<leader>cwl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

        opts.desc = "Add workspace folder"
        vim.keymap.set("n", "<leader>cwa", function()
          vim.lsp.buf.add_workspace_folder()
        end, opts)

        opts.desc = "Remove workspace folder"
        vim.keymap.set("n", "<leader>cwr", function()
          vim.lsp.buf.remove_workspace_folder()
        end, opts)
      end,
    })
  end,
}
