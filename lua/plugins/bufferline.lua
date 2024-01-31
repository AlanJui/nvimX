return {
  "akinsho/bufferline.nvim",
  lazy = false,
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Goto next buffer" },
    { "<S-tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Goto prev buffer" },
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  },
  config = function()
    local opts = {
      options = {
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
      -- stylua: ignore
      right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    }
    require("bufferline").setup(opts)
    --   require("utils").load_mapping("bufferline")
  end,
}
