return {
  "stevearc/aerial.nvim",
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ct", "<cmd>AerialToggle!<CR>", desc = "Toggle code outline window" },
  },
  config = function()
    require("aerial").setup({
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    })
    -- local opts = { noremap = true, silent = true }
    -- opts.desc = "Toggle code outline window"
    -- vim.keymap.set("n", "<leader>ct", "<cmd>AerialToggle!<CR>", opts)
  end,
}
