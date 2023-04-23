return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "ahmedkhalf/project.nvim",
      "cljoly/telescope-repo.nvim",
      "stevearc/aerial.nvim",
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
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fB", "<cmd>Telescope file_browser<cr>", desc = "Browser" },
      { "<leader>fo", "<cmd>Telescope frecency theme=dropdown previewer=false<cr>", desc = "Recent" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- git
      { "<leader>gl", "<cmd>Telescope repo list<cr>", desc = "List Git Repo" },
      { "<leader>gC", "<cmd>Telescope conventional_commits<cr>", desc = "Conventional Commits" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current Buffer" },
      -- { "<leader>sw", "<cmd>Telescope live_grep<cr>", desc = "Workspace Live Grep" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      -- trouble
      { "<leader>xd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>xD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      -- System
      { "<leader>zc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>zC", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>zo", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>zk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>zs", "<cmd>Telescope luasnip<cr>", desc = "Snippets" },
    },
    opts = {},
    ---------------------------------------------------------------------------
    config = function()
      local Util = require("lazyvim.util")
      ------------------------------------------------------------------------------
      local telescope = require("telescope")
      local icons = require("config.icons")
      local actions = require("telescope.actions")
      local actions_layout = require("telescope.actions.layout")
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
          -- mappings = mappings,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          prompt_prefix = " ",
          selection_caret = " ",
          mappings = {
            i = {
              ["<c-t>"] = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
              end,
              ["<a-t>"] = function(...)
                return require("trouble.providers.telescope").open_selected_with_trouble(...)
              end,
              ["<a-i>"] = function()
                Util.telescope("find_files", { no_ignore = true })()
              end,
              ["<a-h>"] = function()
                Util.telescope("find_files", { hidden = true })()
              end,
              ["<C-Down>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
              end,
              ["<C-Up>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
              end,
              ["<C-f>"] = function(...)
                return require("telescope.actions").preview_scrolling_down(...)
              end,
              ["<C-b>"] = function(...)
                return require("telescope.actions").preview_scrolling_up(...)
              end,
            },
            n = {
              ["q"] = function(...)
                return require("telescope.actions").close(...)
              end,
            },
          },
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
        },
      }
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("project")
      telescope.load_extension("projects")
      telescope.load_extension("aerial")
      telescope.load_extension("dap")
      telescope.load_extension("frecency")
      telescope.load_extension("luasnip")
      telescope.load_extension("conventional_commits")
      telescope.load_extension("lazy")

      ------------------------------------------------------------------------------
      -- WhichKey: Telescope
      ------------------------------------------------------------------------------
      local function map(mode, lhs, rhs, opts)
        local keys = require("lazy.core.handler").handlers.keys
        ---@cast keys LazyKeysHandler
        -- do not create the keymap if a lazy keys handler exists
        if not keys.active[keys.parse({ lhs, mode = mode }).id] then
          opts = opts or {}
          opts.silent = opts.silent ~= false
          vim.keymap.set(mode, lhs, rhs, opts)
        end
      end

      map("<leader>/", Util.telescope("live_grep"), { desc = "Grep (root dir)" })
      -- map("n", "<leader><space>", "<cmd>Telescope find_files", { desc = "Find Files" })
      map("n", "<leader><space>", Util.telescope("files"), { desc = "Find Files (root dir)" })
      -- map("n", "<leader>bf", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
      map("n", "<leader>bf", function()
        require("telescope.builtin").current_buffer_fuzzy_find()
      end, { desc = "Buffer Fuzzy Find" })
      -- Find files
      -- map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
      map("n", "<leader>ff", Util.telescope("files"), { desc = "Find Files (root dir)" })
      map("n", "<leader>fF", Util.telescope("files", { cwd = false }), { desc = "Find Files (cwd)" })
      map("n", "<leader>fo", "<cmd>Telescope frecency theme=dropdown previewer=false<cr>", { desc = "Recent" })
      map("n", "<leader>fl", "<cmd>Telescope file_browser<cr>", { desc = "Browser" })
      map("n", "<leader>fp", function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end, { desc = "Find Plugin File" })
      -- search files by keyword
      map("n", "<leader>sg", Util.telescope("live_grep"), { desc = "Grep (root dir)" })
      map("n", "<leader>sG", Util.telescope("live_grep"), { cwd = false, desc = "Grep (cwd)" })
      map("n", "<leader>sw", Util.telescope("grep_string"), { desc = "Word (root dir)" })
      map("n", "<leader>sW", Util.telescope("grep_string"), { cwd = false, desc = "Word (cwd)" })
      -- Preview Colorscheme
      map(
        "n",
        "<leader>zs",
        Util.telescope("colorscheme"),
        { enable_preview = true, desc = "Colorscheme with preview" }
      )
      -- find special word in program
      map("n", "<leader>cs", function()
        Util.telescope("lsp_document_symbols", {
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
      end, { desc = "Goto Symbol" })
      map("n", "<leader>cS", function()
        Util.telescope("lsp_dynamic_workspace_symbols", {
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
      end, { desc = "Goto Symbol (Workspace)" })
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = true,
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
