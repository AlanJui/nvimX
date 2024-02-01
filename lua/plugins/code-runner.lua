return {
  {
    "stevearc/overseer.nvim",
    opts = {},
    config = function()
      require("overseer").setup({
        templates = { "builtin", "user.cpp_build" },
        -- templates = { "builtin", "user.run_script" },
      })
    end,
  },
  {
    "pianocomposer321/officer.nvim",
    dependencies = "stevearc/overseer.nvim",
    config = function()
      require("officer").setup({
        create_mappings = true,
        components = { "user.track_history" },
      })

      local opts = { noremap = true, silent = true }
      opts.desc = "Run last task"
      vim.keymap.set("n", "<LEADER><CR>", require("utils.overseer_util").restart_last_task, opts)
    end,
  },
  {
    "pianocomposer321/yabs.nvim",
    keys = {
      { "<leader>rk", ":2TermExec cmd='npx kill-port 8000'<CR>", desc = "Kill Port" },
      { "<leader>rg", ":2TermExec cmd='git status'<CR>", desc = "git status" },
      -- Lua Script
      {
        "<leader>rlr",
        ":TermExec direction=horizontal cmd='lua %'<CR>",
        desc = "Run current lua file",
      },
      -- Python
      {
        "<leader>rpp",
        ":TermExec direction=horizontal cmd='python %'<CR>",
        desc = "Run current Python file",
      },
      {
        "<leader>rpk",
        ":TermExec direction=horizontal cmd='pylint %'<CR>",
        desc = "Lint current file",
      },
      -- Django
      { "<leader>rdr", ":TermExec cmd='poetry run python manage.py runserver'<CR>", desc = "Runserver" },
      {
        "<leader>rdR",
        ":TermExec cmd='poetry run python manage.py runserver --noreload'<CR>",
        "Runserver --noreload",
      },
      { "<leader>rdS", ":2TermExec cmd='poetry run python manage.py shell'<CR>", desc = "Django Shell" },
      {
        "<leader>rds",
        ":2TermExec cmd='poetry run python manage.py createsuperuser'<CR>",
        "Create super user",
      },
      {
        "<leader>rdc",
        ":2TermExec cmd='echo yes | poetry run python manage.py collectstatic --noinput'<CR>",
        desc = "Collect all static files",
      },
      {
        "<leader>rdm",
        ":2TermExec cmd='poetry run python manage.py makemigrations'<CR>",
        desc = "Update DB schema",
      },
      { "<leader>rdM", ":2TermExec cmd='poetry run python manage.py migrate'<CR>", desc = "Migrate DB" },
    },
    config = function()
      local yabs = require("yabs")
      local telescope = require("telescope")

      local lua_config = {
        tasks = {
          run = {
            command = "lua %",
            type = "shell",
            output = "terminal",
          },
        },
      }

      local python_config = {
        default_task = "run",
        tasks = {
          build = { command = "python %", output = "terminal" },
          run = { command = "python %", output = "terminal" },
          lint = { command = "pylint %", output = "terminal" },
        },
      }

      yabs:setup({
        languages = {
          lua = lua_config,
          python = python_config,
          c = {
            default_task = "build_and_run",
            tasks = {
              build = {
                command = "gcc main.c -o main",
                output = "quickfix", -- Where to show output of the
                -- command. Can be `buffer`,
                -- `consolation`, `echo`,
                -- `quickfix`, `terminal`, or `none`
                opts = { -- Options for output (currently, there's only
                  -- `open_on_run`, which defines the behavior
                  -- for the quickfix list opening) (can be
                  -- `never`, `always`, or `auto`, the default)
                  open_on_run = "always",
                },
              },
              run = { -- You can specify as many tasks as you want per
                -- filetype
                command = "./main",
                output = "terminal",
              },
              build_and_run = { -- Setting the type to lua means the command
                -- is a lua function
                command = function()
                  -- The following api can be used to run a task when a
                  -- previous one finishes
                  -- WARNING: this api is experimental and subject to
                  -- changes
                  require("yabs"):run_task("build", {
                    -- Job here is a plenary.job object that represents
                    -- the finished task, read more about it here:
                    -- https://github.com/nvim-lua/plenary.nvim#plenaryjob
                    on_exit = function(Job, exit_code)
                      -- The parameters `Job` and `exit_code` are optional,
                      -- you can omit extra arguments or
                      -- skip some of them using _ for the name
                      if exit_code == 0 then
                        require("yabs").languages.c:run_task("run")
                      end
                    end,
                  })
                end,
                type = "lua",
              },
            },
          },
        },
        tasks = {
          build = { command = "echo building project...", output = "terminal" },
          run = { command = "echo running project...", output = "echo" },
          optional = {
            command = "echo runs on condition",
            condition = require("yabs.conditions").file_exists("filename.txt"),
          },
        },
        opts = {
          output_types = { quickfix = { open_on_run = "always" } },
        },
      })

      telescope.load_extension("yabs")
    end,
  },
}
