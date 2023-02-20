--------------------------------------------------------------------
-- (1) Setup auto-completion: cmp.nvim
-- (2) Setup langserver via mason, mason-lspconfig and lspconfig
-- (3) Setup Linters and Formatters
--------------------------------------------------------------------
-- require("lsp/auto-cmp")
-- require("plugins-rc/copilot")
-- require("lsp/lsp-servers")
-- require("lsp/null-langserver")
-- require("lsp/lspsaga")
--------------------------------------------------------------------
-- easy way
--------------------------------------------------------------------
require("plugins-rc/copilot")
require("lsp/quick-lsp")
require("lsp/null-langserver")
-- require("plugins-rc/mason-null-ls-rc")
require("lsp/lspsaga")
