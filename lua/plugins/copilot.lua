-- AI auto-completion
return {
  {
    "zbirenbaum/copilot.lua",
    -- enabled = false,
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function(_, opts)
      require("copilot_cmp").setup()
    end,
  },
}
