return {
  -- Lua DAP
  {
    "jbyuki/one-small-step-for-vimkind",
  },
  -- Python DAP
  {
    "mfussenegger/nvim-dap-python",
  },
  -- JavaScript DAP
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "microsoft/vscode-js-debug",
      opt = true,
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    },
  },
  -- Neovim DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text" },
      {
        "rcarriga/nvim-dap-ui",
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Repl" },
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      -- Lua adapter
      {
        "<leader>daL",
        function()
          require("osv").launch({ port = 8086 })
        end,
        desc = "Start Lua Language Server",
      },
      {
        "<leader>dal",
        function()
          require("osv").run_this()
        end,
        desc = "Start Lua Debugging",
      },
    },
    -- config
    config = function()
      local Config = require("lazyvim.config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      local dap = require("dap")
      require("plugins.dap.lua").setup(dap)
      require("plugins.dap.python").setup(dap)
      require("plugins.dap.javascript").setup(dap)
    end,
  },
}
