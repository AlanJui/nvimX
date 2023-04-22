return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "mfussenegger/nvim-dap-python" },
    { "mxsdev/nvim-dap-vscode-js" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },
    {
      "rcarriga/nvim-dap-ui",
      -- tag = "v3.6.4",
      opts = {
        icons = { expanded = "▾", collapsed = "▸" },
        -- layouts = {
        --   {
        --     elements = {
        --       "scopes",
        --       "breakpoints",
        --       "stacks",
        --       "watches",
        --     },
        --     size = 80,
        --     position = "right",
        --   },
        --   {
        --     elements = {
        --       "repl",
        --       "console",
        --     },
        --     size = 10,
        --     position = "bottom",
        --   },
        -- },
      },
    },
  },
  -- stylua: ignore
  keys = {
    -- { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
    -- { "<leader>de", function() require("dapui").eval() end, mode = {"n", "v"}, desc = "Evaluate", },
    { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor", },
    { "<leader>dC", function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint", },
    { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle UI", },
    { "<leader>db", function() require("dap").step_back() end, desc = "Step Back", },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue", },
    { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect", },
    { "<leader>dg", function() require("dap").session() end, desc = "Get Session", },
    { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Hover Variables", },
    { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into", },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over", },
    { "<leader>dp", function() require("dap").pause.toggle() end, desc = "Pause", },
    { "<leader>dq", function() require("dap").close() end, desc = "Quit", },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
    { "<leader>ds", function() require("dap").continue() end, desc = "Start", },
    { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
    { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate", },
    { "<leader>du", function() require("dap").step_out() end, desc = "Step Out", },
  },
  config = function()
    require("nvim-dap-virtual-text").setup({
      commented = true,
    })
    local dap, dapui = require("dap"), require("dapui")

    -- Signs
    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "", linehl = "", numhl = "" })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    ------------------------------------------------------------------
    -- set up debugger
    ------------------------------------------------------------------
    require("plugins.dap.python").setup(dap)
    require("plugins.dap.lua").setup(dap)
  end,
}
