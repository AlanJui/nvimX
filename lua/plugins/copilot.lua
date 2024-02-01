-- AI auto-completion
return {
  {
    "zbirenbaum/copilot.lua",
    -- enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })

      -- Copilot suggestion is automatically hidden when popupmenu-completion
      -- is open. In case you use a custom menu for completion, you can set
      -- the copilot_suggestion_hidden buffer variable to true to have the
      -- same behavior.
      -- local cmp = require("cmp")
      -- cmp.event:on("menu_opened", function()
      --   vim.b.copilot_suggestion_hidden = true
      -- end)
      --
      -- cmp.event:on("menu_closed", function()
      --   vim.b.copilot_suggestion_hidden = false
      -- end)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
