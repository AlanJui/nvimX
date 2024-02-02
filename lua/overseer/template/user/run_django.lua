return {
  name = "run Django",
  builder = function()
    local file = vim.fn.expand("%:p")
    local cmd = {}
    if vim.bo.filetype == "python" then
      cmd = { "poetry run", "python manage.py runserver" }
    end
    return {
      cmd = cmd,
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
