-- Only load whichkey after all the gui
return {
  "folke/which-key.nvim",
  keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
  init = function()
    require("utils").load_mappings("whichkey")
  end,
  cmd = "WhichKey",
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      mode = { "n", "v" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["g"] = { name = "+goto" },
      ["gz"] = { name = "+surround" },
      ["<leader><tab>"] = { name = "+tabs" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>cf"] = { name = "+find" },
      ["<leader>cw"] = { name = "+workspace" },
      -- ["<leader>c"] = {
      --   name = "+code",
      --   ["f"] = { name = "+find" },
      --   ["w"] = { name = "+workspace" },
      -- },
      ["<leader>d"] = { name = "+debug" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>r"] = { name = "+running code" },
      ["<leader>rp"] = { name = "+Python" },
      ["<leader>rd"] = { name = "+Django" },
      ["<leader>rl"] = { name = "+Lua" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+utilities" },
      ["<leader>uu"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
      ["<leader>z"] = { name = "+system" },
    })
  end,
}
