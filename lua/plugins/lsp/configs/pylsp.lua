return {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          maxLineLength = 120,
        },
        mccabe = { enabled = false },
        pyflakes = { enabled = true },
        flake8 = { enabled = false },
        mypy = { enabled = true },
      },
      pycodestyle = {
        ignore = { "W391" },
        maxLineLength = 100,
      },
    },
  },
}
