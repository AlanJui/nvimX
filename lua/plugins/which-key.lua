return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "i", "j", "k", "h", "u", "v" },
      v = { "j", "k" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    local n_opts = { mode = "n", prefix = "<leader>" }
    local normal_keymap = {
      -- Top Menu
      ["<Space>"] = { "<c-^>", "Quick Switch 2 Buffers" }, -- Switch between 2 buffers
      ["\\"] = { "<cmd>Telescope live_grep<cr>", "Grep text" },
      [","] = { ":Telescope buffers<CR>", "Show buffers" },
      ["L"] = { "<cmd>Lazy<cr>", "Run Lazy" },
      ["v"] = { ":Vifm<CR>", "ViFm" },
      -- Actions
      a = {
        name = "Actions",
        h = { ":let @/ = ''<CR>", "remove search highlight" },
        f = { ":set filetype=htmldjango<CR>", "set file type to django template" },
        F = { ":set filetype=html<CR>", "set file type to HTML" },
        n = { ":set nonumber!<CR>", "on/off line-numbers" },
        N = { ":set norelativenumber!<CR>", "on/off relative line-numbers" },
        w = { ":set wrap!<CR>", "on/off line wrap" },
      },
      -- Find/Search
      f = {
        name = "Find/Search",
        b = { "<cmd>Telescope buffers<cr>", "Switch buffers" },
        g = { "<cmd>Telescope live_grep<cr>", "Grep text" },
        f = { "<cmd>Telescope find_files<cr>", "Find Files" },
        F = {
          name = "Search by File Name",
          a = { "<cmd>Telescope telescope-alternate alternate_file<cr>", "Alternate file" },
          b = { "<cmd>Telescope buffers<cr>", "Switch buffers" },
          B = { "<cmd>Telescope file_browser<cr>", "File browser" },
          h = { "<cmd>Telescope frecency<cr>", "Most (f)recently used files" },
          f = { "<cmd>Telescope find_files<cr>", "Find Files" },
        },
        k = {
          name = "Search by Keywords",
          b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy find current buffer" },
          G = {
            "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args({default_text=vim.fn.expand('<cword>')})<cr>",
            "Grep cursor word with args",
          },
          c = { "<cmd>Telescope grep_string<cr>", "Grep text under cursor" },
          t = { "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args()<cr>", "Grep text with args" },
        },
        t = {
          name = "Search Tools",
          d = { "<cmd>Telescope diagnostics<cr>", "Find Diagnostics" },
          m = { "<cmd>MarksListBuf<cr>", "Find Mark in buffer" },
          o = { "<cmd>Telescope aerial<cr>", "Code Outline" },
          c = { "<cmd>Telescope commands<cr>", "Commands" },
          h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
          H = { "<cmd>Telescope heading<cr>", "Find Header" },
          k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
          l = { "<cmd>Telescope luasnip<cr>", "Search snippet" },
          M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
          p = { "<cmd>Telescope lazy<cr>", "List lazy plugins info" },
          P = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "Find project" },
          r = { "<cmd>Telescope registers<cr>", "Find Registers" },
          s = {
            function()
              require("telescope.builtin").colorscheme({ enable_preview = true })
            end,
            "Colorscheme",
          },
          S = { "<cmd>Telescope symbols<cr>", "Search symbols" },
          t = { "<cmd>TodoTelescope keywords=TODO,FIX<cr>", "Find TODOs and FIXMEs" },
        },
      },
      -- Replace
      R = {
        name = "Replace",
        -- Spectre
        r = { [[<cmd>lua require('spectre').open_visual({select_word=true})<cr>]], "Replace cursor word" },
        f = { [[viw:lua require('spectre').open_file_search()<cr>]], "Replace in current file" },
        o = { [[<cmd>lua require('spectre').open()<CR>]], "Open spectre" },
      },
      -- Buffer
      b = {
        name = "Buffer",
        b = { "<c-^>", "Quick Switch 2 Buffers" }, -- Switch between 2 buffers
        q = { ":q!<cr>", "Quit without saving" },
        Q = { ":qa!<cr>", "Quit all windows without saving" },
        x = { "bdelete", "Close File (Delete buffer)" },
      },
      -- Code
      c = {
        name = "Code",
        F = { "<cmd>lua vim.lsp.buf.format()<CR>", "Formatting code" },
        b = {
          name = "Splitting/Joining blocks of code",
          j = { "<cmd>lua require('treesj').join()<CR>", "Join node under cursor" },
          s = { "<cmd>lua require('treesj').split()<CR>", "Split node under cursor" },
        },
        s = { name = "Surround" },
        -- w = { name = "Workspace" },
      },
      -- Debugging
      d = {
        name = "Debug",
        a = {
          name = "Adapter",
        },
        t = {
          name = "Test",
        },
      },
      -- Run/Build
      r = {
        name = "Build and Run",
        c = { name = "C" },
        C = { name = "C++" },
        p = { name = "Python" },
        d = { name = "Django" },
      },
      -- Git
      g = {
        name = "Git",
        -- telescope
        l = { "<cmd>Telescope git_status<cr>", "Changed files" },
        -- vim-fugitive plugin
        -- S = { ":2TermExec cmd='git status'<CR>", "git status" },
        s = { "<cmd>Git<cr>", "Status" },
        -- d = { "<cmd>Gdiff<cr>", "Diff" },
        r = { "<cmd>Gread<cr>", "Read" },
        p = { "<cmd>Git push<cr>", "Push" },
        c = { "<cmd>Git commit --verify<cr>", "Commit" },
        -- gitsigns plugin
        b = { "<cmd>lua require 'gitsigns'.blame_line({ full = true })<cr>", "Blame Line" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        a = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        d = { "<cmd>lua require 'gitsigns'.diffthis()<cr>", "Diff This" },
        D = {
          name = "Diff/Debug",
          f = {
            name = "Diff view",
            o = { "<cmd>DiffviewOpen<CR>", "Open diffview" },
            u = { "<cmd>DiffviewOpen -uno<CR>", "Open diffview hide untracked files" },
            h = { "<cmd>DiffviewFileHistory<CR>", "Open diffview file history" },
          },
        },
        e = {
          name = "Extra action",
          b = { "<cmd>Git blame<cr>", "Blame" },
          m = { "<cmd>Telescope git_commits<cr>", "Find git commits" },
          l = { "<cmd>Telescope advanced_git_search search_log_content<cr>", "Search in repo log content" },
          L = { "<cmd>Telescope advanced_git_search search_log_content_file<cr>", "Search in file log content" },
          d = { "<cmd>lua require 'gitsigns'.diffthis('~')<cr>", "Diff This ~" },
          p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
          a = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
          r = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
          u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
          -- gv.vim plugin
          h = { "<cmd>GV!<cr>", "List current file commits history" },
          -- vim-rhubarb plugin
          -- b = {'<cmd>Gbrowser<cr>', 'browse github'},
        },
      },
      -- LSP
      l = {
        name = "LSP",
        -- diagnostics
        d = {
          name = "Diagnostics",
          w = { ":Telescope diagnostics<CR>", "List diagnostics in worksapce" },
          c = {
            ":Telescope diagnostics bufnr=0<CR>",
            "List diagnostics current file",
          },
          f = {
            "<cmd>lua vim.diagnostic.open_float()<CR>",
            "Open diagnostics floating",
          },
          p = {
            "<cmd>lua vim.diagnostic.goto_prev()<CR>",
            "Goto prev diagnostics",
          },
          n = {
            "<cmd>lua vim.diagnostic.goto_next()<CR>",
            "Goto next diagnostics",
          },
        },
        f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Formatting code" },
        k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show HoverDocument" },
        g = {
          name = "goto",
          D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
          d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
          p = { ":Lspsaga peek_definition<CR>", "Peek definition" },
          t = {
            "<cmd>lua vim.lsp.buf.type_definition()<CR>",
            "Go to type definition",
          },
          i = {
            "<cmd>lua vim.lsp.buf.implementation()<CR>",
            "Go to Implementation",
          },
          r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
        },
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename code" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
        w = {
          name = "workspace",
          l = {
            "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
            "List workspace folders",
          },
          a = {
            "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
            "Add folder to workspace",
          },
          r = {
            "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
            "Remove folder from workspace",
          },
        },
      },
      -- Project
      -- p = {
      --   name = "Project",
      --   q = { "<cmd>TodoQuickFix<cr>", "List all TODOs in project quickfix list" },
      --   l = { "<cmd>TodoLocList<cr>", "List all TODOs in project" },
      --   t = { "<cmd>TodoTrouble<cr>", "List all TODOs in project with trouble" },
      --   s = { "<cmd>TodoTelescope<cr>", "Search through all project TODOs with Telescope" },
      -- },
      -- s = {
      --   name = "Session",
      --   -- session
      --   a = { "<cmd>SaveSession<cr>", "Add auto session" },
      --   l = { "<cmd>RestoreSession<cr>", "Load auto session" },
      --   d = { "<cmd>DeleteSession<cr>", "Delete auto session" },
      --   f = { "<cmd>SearchSession<cr>", "Search auto session" },
      -- },
      -- Toggle options
      -- t = {
      --   name = "Toggle option",
      -- },
      -- utilities
      u = {
        name = "Utilities",
        -- l = {
        --   name = "LiveServer",
        --   l = { ":Bracey<CR>", "start live server" },
        --   L = { ":BraceyStop<CR>", "stop live server" },
        --   r = { ":BraceyReload<CR>", "web page to be reloaded" },
        -- },
        t = {
          name = "Terminal",
          d = { "TermExec python manage.py shell<CR>", "Django-admin Shell" },
          p = { "TermExec python<CR>", "Python shell" },
          n = { "TermExec node<CR>", "Node.js shell" },
          v = {
            "TermExec --wintype='vsplit' --position='right'<CR>",
            "Debug Term...",
          },
        },
        m = {
          name = "Markdown",
          m = { ":MarkdownPreview<CR>", "start markdown preview" },
          M = { ":MarkdownPreviewStop<CR>", "stop markdown preview" },
        },
        u = {
          name = "UML",
          v = { ":PlantumlOpen<CR>", "start PlantUML preview" },
          o = {
            ":PlantumlSave docs/diagrams/out.png<CR>",
            "export PlantUML diagram",
          },
        },
      },
      x = {
        name = "Trouble",
        x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
        w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace diagnostics" },
        d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document diagnostics" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
      },
      -- Windows
      w = {
        name = "Window",
        ["-"] = { ":split<CR>", "Horiz. window" },
        ["_"] = { ":vsplit<CR>", "Vert. window" },
        ["|"] = { ":vsplit<CR>", "Vert. window" },
        ["<Up>"] = { "<cmd>wincmd -<CR>", "Shrink down" },
        ["<Down>"] = { "<cmd>wincmd +<CR>", "Grow up" },
        ["<Left>"] = { "<cmd>wincmd <<CR>", "Shrink narrowed" },
        ["<Right>"] = { "<cmd>wincmd ><CR>", "Grow widder" },
        c = { ":close<CR>", "Close window" },
        k = { "<C-w>k", "Up window" },
        j = { "<C-w>j", "Down window" },
        h = { "<C-w>h", "Left window" },
        l = { "<C-w>l", "Right window" },
        f = { "<cmd>FocusToggle<cr>", "Toggle window focus" },
        s = { "<cmd>FocusSplitNicely<cr>", "Split a window on golden ratio" },
        o = { "<cmd>AerialToggle<cr>", "Toggle code outline window" }, -- aerial.nvim plugin
        O = { "<cmd>lua require('nvim-window').pick()<cr>", "Choose window" },
        m = { "<cmd>FocusMaxOrEqual<cr>", "Toggle window zoom" },
        Z = { ":tabnew %<CR>", "Zoom-in" },
        z = { ":tabclose<CR>", "Zoom-out" },
      },
      z = {
        name = "System",
      },
    }
    wk.register(normal_keymap, n_opts)

    local v_opts = { mode = "v", prefix = "<leader>" }
    local visual_keymap = {
      g = {
        name = "Git",
        Y = {
          "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
          "Open permalinks of selected area",
        },
      },
      r = {
        name = "Refactor",
      },
    }
    wk.register(visual_keymap, v_opts)

    local g_opts = { mode = "n", prefix = "g" }
    local global_keymap = {
      o = {
        name = "Go with go.nvim",
        a = { "<cmd>GoAlt<CR>", "Alternate impl and test" },
        i = { "<cmd>GoInstall<CR>", "Go install" },
        b = { "<cmd>GoBuild<CR>", "Go build" },
        d = { "<cmd>GoDoc<CR>", "Go doc" },
        f = { "<cmd>GoFmt<cr>", "Formatting code" },
        r = { "<cmd>!go run %:.<CR>", "Go run current file" },
        e = { "<cmd>GoIfErr<CR>", "Add if err" },
        w = { "<cmd>GoFillSwitch<CR>", "Fill switch" },
        g = { "<cmd>GoAddTag<CR>", "Add json tag" },
        c = { "<cmd>lua require('go.comment').gen()<CR>", "Comment current func" },
      },
    }
    wk.register(global_keymap, g_opts)
  end,
}
