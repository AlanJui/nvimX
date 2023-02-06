----------------------------------------------------------------------------------------------------
-- Use Mason to install js-debug-adapter
-- the vscode-js-debug is called js-debug-adapter in mason
----------------------------------------------------------------------------------------------------
local ok, dap_clinet = pcall(require, "dap")
local ok2, debug_adapter = pcall(require, "debugger/adapter/vscode-js")
if not ok or not ok2 then
	return
end

local M = {}

local nvim_config = _G.GetConfig()
local node_path = nvim_config.nodejs.node_path
local debugger_path = nvim_config.nodejs.debugger_path
local debugger_cmd = { nvim_config.nodejs.debugger_cmd }

local function setup_debug_adapter()
	debug_adapter.setup({
		-- Path of node executable. Defaults to $NODE_PATH, and then "node"
		-- node_path = node_path,
		-- Path to vscode-js-debug installation.
		-- debugger_path = debugger_path,
		-- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
		-- debugger_cmd = debugger_cmd,
		-- which adapters to register in nvim-dap
		-- adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		adapters = { "pwa-node" },
		-- Path for file logging
		log_file_path = vim.fn.stdpath("cache") .. "/debug_adapter.log",
		-- Logging level for output to console. Set to false to disable console output.
		-- log_console_level = vim.log.levels.ERROR,
		log_console_level = vim.log.levels.DEBUG,
	}, true)
end

function M.setup()
	-- configure run time environment for DAP of vscode-js-debug
	setup_debug_adapter()
	-- language configurations
	for _, language in ipairs({ "typescript", "javascript" }) do
		dap_clinet.configurations[language] = {
			{
				name = "Launch Chrome",
				type = "pwa-chrome",
				request = "launch",
				url = "http://localhost:8080",
				webRoot = "${workspaceFolder}",
			},
			{
				name = "Launch file",
				type = "pwa-node",
				request = "launch",
				program = "${file}",
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
			},
			{
				name = "Attach",
				type = "pwa-node",
				request = "attach",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
				console = "integratedTerminal",
			},
			{
				name = "Launch Program",
				type = "pwa-node",
				request = "launch",
				skipFiles = {
					"<node_internals>/**",
				},
				program = "${workspaceFolder}/bin/www",
				console = "integratedTerminal",
			},
			{
				name = "Launch app.js",
				type = "pwa-node",
				request = "launch",
				skipFiles = {
					"<node_internals>/**",
				},
				program = "${workspaceFolder}/app.js",
				console = "integratedTerminal",
			},
		}
	end
end

return M
