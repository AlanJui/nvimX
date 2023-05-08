return {
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
