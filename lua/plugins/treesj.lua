-- Neovim plugin for splitting/joining blocks of code like arrays,
-- hashes, statements, objects, dictionaries, etc.
return {
  "Wansmer/treesj",
  lazy = false,
  cmd = "TSJToggle",
  keys = {
    { "<leader>cs", "<cmd>TSJSplit<CR>", desc = "Split node under cursor" },
    { "<leader>cj", "<cmd>TSJJoin<CR>", desc = "Join node under cursor" },
    { "<leader>ct", "<cmd>TSJToggle<CR>", desc = "Toggle(split/join) node under cursor" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({})
    -- For use default preset and it work with dot
    -- vim.keymap.set("n", "<leader>cm", require("treesj").toggle, { desc = "Toggle block(Split/Join)" })
    -- For extending default preset with `recursive = true`, but this doesn't work with dot
    vim.keymap.set("n", "<leader>cm", function()
      require("treesj").toggle({ split = { recursive = true } })
    end, { desc = "Toggle blocks recursivly (Split/Join)" })
  end,
}
