return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local chatgpt = require("chatgpt")
    local wk = require("which-key")

    wk.register({
      c = {
        name = "ChatGPT",
        e = {
          function()
            chatgpt.edit_with_instructions()
          end,
          "Edit with instructions",
        },
      },
    }, {
      prefix = "<leader>",
      mode = "v",
    })
  end,
}
