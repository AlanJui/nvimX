return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-project.nvim",
      -- "nvim-telescope/telescope-dap.nvim",
      "ahmedkhalf/project.nvim",
      "cljoly/telescope-repo.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "kkharji/sqlite.lua",
      "aaronhallaert/advanced-git-search.nvim",
      "benfowler/telescope-luasnip.nvim",
      "olacin/telescope-cc.nvim",
      "tsakirist/telescope-lazy.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- buffers
      {
        "<leader>/",
        function()
          require("lazyvim.util").telescope("live_grep")
        end,
        desc = "Grep (root dir)",
      },
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>bf", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Buffers" },
      -- code
      { "<leader>cD", "<cmd>Telescope dap configurations<cr>", desc = "DAP Config Picker" },
      {
        "<leader>cs",
        function()
          require("lazyvim.util").telescope("lsp_document_symbols", {
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>cS",
        function()
          require("lazyvim.util").telescope("lsp_workspace_symbols", {
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
      -- find
      {
        "<leader><space>",
        function()
          require("telescope.builtin").find_files({
            theme = "dropdown",
          })
        end,
        desc = "Find Files",
      },
      {
        "<leader>ff",
        "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>",
        desc = "Find Files (root dir)",
      },
      {
        "<leader>fF",
        function()
          -- require("telescope.builtin").find_files({ cmd = false })
          require("telescope.builtin").find_files({
            cwd = false,
            previewer = true,
            -- layout_strategy = "vertical",
            -- layout_config = {
            --   width = 0.8,
            -- },
          })
        end,
        desc = "Find Files (cwd)",
      },
      { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "Browser" },
      { "<leader>fr", "<cmd>Telescope frecency theme=dropdown previewer=false<cr>", desc = "Frecency Files" },
      { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      -- git
      { "<leader>gr", "<cmd>Telescope repo list<cr>", desc = "List Git Repo" },
      { "<leader>gC", "<cmd>Telescope conventional_commits<cr>", desc = "Conventional Commits" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current Buffer Fuzzy Find" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>fg",
        function()
          -- require("telescope.builtin").live_grep()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Grep (root dir)",
      },
      {
        "<leader>fG",
        function()
          -- require("telescope.builtin").live_grep({ cwd = false })
          require("telescope").extensions.live_grep_args.live_grep_args({ cwd = false })
        end,
        desc = "Grep (cwd)",
      },
      {
        "<leader>fw",
        function()
          require("telescope.builtin").telescope("grep_string")
        end,
        desc = "Word (root dir)",
      },
      {
        "<leader>fW",
        function()
          require("telescope.builtin").telescope("grep_string", { cwd = false })
        end,
        desc = "Word (cwd)",
      },
      -- trouble
      { "<leader>xx", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>xX", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      -- utility
      {
        "<leader>up",
        function()
          require("telescope").extensions.project.project({ display_type = "minimal" })
        end,
        desc = "List",
      },
      -- System
      { "<leader>zh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "Help" },
      { "<leader>zc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>zC", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>zk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>zo", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>zp", "<cmd>Telescope lazy<cr>", desc = "Plugins" },
      { "<leader>zP", "<cmd>lua require'telescope.builtin'.planets{}<cr>", desc = "Pickers" },
      { "<leader>zs", "<cmd>Telescope luasnip<cr>", desc = "Snippets" },
      {
        "<leader>zS",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Colorscheme with preview",
      },
    },
    opts = {},
    ---------------------------------------------------------------------------
    config = function()
      -- local Util = require("lazyvim.util")
      -- local icons = require("config.icons")
      ------------------------------------------------------------------------------
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local actions_layout = require("telescope.actions.layout")
      local lga_actions = require("telescope-live-grep-args.actions")
      local transform_mod = require("telescope.actions.mt").transform_mod
      local custom_actions = transform_mod({
        -- VisiData
        visidata = function(prompt_bufnr)
          -- Get the full path
          local content = require("telescope.actions.state").get_selected_entry()
          if content == nil then
            return
          end
          local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

          -- Close the Telescope window
          require("telescope.actions").close(prompt_bufnr)

          -- Open the file with VisiData
          local utils = require("utils")
          utils.open_term("vd " .. full_path, { direction = "float" })
        end,

        -- File browser
        file_browser = function(prompt_bufnr)
          local content = require("telescope.actions.state").get_selected_entry()
          if content == nil then
            return
          end

          local full_path = content.cwd
          if content.filename then
            full_path = content.filename
          elseif content.value then
            full_path = full_path .. require("plenary.path").path.sep .. content.value
          end

          -- Close the Telescope window
          require("telescope.actions").close(prompt_bufnr)

          -- Open file browser
          -- vim.cmd("Telescope file_browser select_buffer=true path=" .. vim.fs.dirname(full_path))
          require("telescope").extensions.file_browser.file_browser({
            select_buffer = true,
            path = vim.fs.dirname(full_path),
          })
        end,
      })

      local mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["?"] = actions_layout.toggle_preview,
          ["<C-s>"] = custom_actions.visidata,
          ["<A-f>"] = custom_actions.file_browser,
        },
        n = {
          ["s"] = custom_actions.visidata,
          ["<A-f>"] = custom_actions.file_browser,
        },
      }

      local opts = {
        defaults = {
          -- prompt_prefix = icons.ui.Telescope .. " ",
          -- selection_caret = icons.ui.Forward .. " ",
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = mappings,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
          },
          git_files = {
            theme = "dropdown",
            previewer = false,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            previewer = false,
            hijack_netrw = true,
            mappings = mappings,
          },
          project = {
            hidden_files = false,
            theme = "dropdown",
          },
          live_grep_args = {
            auto_quoting = true, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = { -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            },
            -- ... also accepts theme settings, for example:
            -- theme = "dropdown", -- use dropdown theme
            -- theme = { }, -- use own theme spec
            -- layout_config = { mirror=true }, -- mirror preview pane
          },
        },
      }
      telescope.setup(opts)
      -- telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("project")
      telescope.load_extension("projects")
      -- telescope.load_extension("aerial")
      -- telescope.load_extension("dap")
      telescope.load_extension("frecency")
      telescope.load_extension("luasnip")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("conventional_commits")
      telescope.load_extension("lazy")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git" },
        ignore_lsp = { "null-ls" },
      })
    end,
  },
}
