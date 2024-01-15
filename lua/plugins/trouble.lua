-- Trouble comes with the following commands:
--
-- Trouble [mode]: open the list
-- TroubleClose [mode]: close the list
-- TroubleToggle [mode]: toggle the list
-- TroubleRefresh: manually refresh the active list
--
-- Modes:
--  * document_diagnostics: document diagnostics from the builtin LSP client
--  * workspace_diagnostics: workspace diagnostics from the builtin LSP client
--  * lsp_references: references of the word under the cursor from the builtin LSP client
--  * lsp_definitions: definitions of the word under the cursor from the builtin LSP client
--  * lsp_type_definitions: type definitions of the word under the cursor from the builtin LSP client
--  * quickfix: quickfix items
--  * loclist: items from the window's location list
return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "TroubleToggle", "Trouble", "TroubleClose", "TroubleRefresh" },
  opts = { use_diagnostic_signs = true },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          vim.cmd.cprev()
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          vim.cmd.cnext()
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
}
