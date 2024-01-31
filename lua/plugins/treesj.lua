-- Neovim plugin for splitting/joining blocks of code like arrays,
-- hashes, statements, objects, dictionaries, etc.
return {
  "Wansmer/treesj",
  keys = { "<leader>m", "<leader>j", "<leader>s" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({--[[ your config ]]
    })
  end,
}
