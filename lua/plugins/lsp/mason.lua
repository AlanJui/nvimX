return {

  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  opts = {
    ensure_installed = {
      { "bash-language-server", auto_update = true },
      "shfmt",
      "lua-language-server",
      "stylua",
      -- "luacheck",
      "shellcheck",
      "pyright",
      "debugpy",
      "mypy",
      "pydocstyle",
      -- "djlint",
      "isort",
      "autopep8",
      "black",
      "flake8",
      "jq",
      "js-debug-adapter",
    },
  },
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(_, opts)
    require("mason").setup(opts)
    local mr = require("mason-registry")
    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end
    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
