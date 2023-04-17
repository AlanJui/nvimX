----------------------------------------------------------------------------------------------------
-- Use Mason to install js-debug-adapter
-- the vscode-js-debug is called js-debug-adapter in mason
----------------------------------------------------------------------------------------------------
local ok, dap = pcall(require, "dap")
local ok2, dap_adapter = pcall(require, "dap-vscode-js")
if not ok or not ok2 then return end

local M = {}

function M.setup()
  -- configure run time environment for DAP of vscode-js-debug
  dap_adapter.setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
    -- debugger_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/vscode-js-debug",
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
  })

  -- language configurations
  for _, language in ipairs({ "typescript", "javascript" }) do
    dap.configurations[language] = {
      -- Node.js
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      -- Jest
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      -- Mocha
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Mocha Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/mocha/bin/mocha.js",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      -- {
      --   name = "Launch Program",
      --   type = "pwa-node",
      --   request = "launch",
      --   skipFiles = {
      --     "<node_internals>/**",
      --   },
      --   program = "${workspaceFolder}/bin/www",
      --   console = "integratedTerminal",
      -- },
      -- {
      --   name = "Launch app.js",
      --   type = "pwa-node",
      --   request = "launch",
      --   skipFiles = {
      --     "<node_internals>/**",
      --   },
      --   program = "${workspaceFolder}/app.js",
      --   console = "integratedTerminal",
      -- },
    }
  end
end

return M
