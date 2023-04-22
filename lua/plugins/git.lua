-----------------------------------------------------------
-- Git Tools
-----------------------------------------------------------
return {
  -- A work-in-progress Magit clone for Neovim that is geared toward the Vim philosophy.
  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    keys = {
      {
        "<leader>gn",
        "<cmd>Neogit<cr>",
        desc = "My Neogit",
      },
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup({
        disable_signs = false,
        disable_context_highlighting = false,
        disable_commit_confirmation = false,
        -- customize displayed signs
        signs = {
          -- { CLOSED, OPENED }
          section = { "", "" },
          item = { "", "" },
          hunk = { "", "" },
        },
        integrations = {
          diffview = true,
        },
      })

      -- Notification Highlighting
      vim.cmd([[
					hi NeogitNotificationInfo guifg=#80ff95
					hi NeogitNotificationWarning guifg=#fff454
					hi NeogitNotificationError guifg=#c44323
			]])

      -- Contextual Highlighting
      vim.cmd([[
					hi def NeogitDiffAddHighlight guibg=#404040 guifg=#859900
					hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f
					hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2
					hi def NeogitHunkHeader guifg=#cccccc guibg=#404040
					hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d
			]])
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

				-- stylua: ignore start
				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  -- Git commands in nvim
  "tpope/vim-fugitive",
  -- Fugitive-companion to interact with github
  -- "tpope/vim-rhubarb",
  -- Add git related info in the signs columns and popups
  -- for creating gist
  -- Personal Access Token: ~/.gist-vim
  -- token XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  -- { "mattn/vim-gist", dependencies = "mattn/webapi-vim" },
}
