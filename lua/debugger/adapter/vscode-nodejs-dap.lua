----------------------------------------------------------------------------------------------------
-- Use Mason to install js-debug-adapter
-- the vscode-js-debug is called js-debug-adapter in mason
----------------------------------------------------------------------------------------------------
local ok, dap = pcall(require, "dap")
local ok2, dap_vscode_js = pcall(require, "dap-vscode-js")
if not ok or not ok2 then
	return
end

local M = {}

local node_path = os.getenv("HOME") .. "/n/bin/node"
-- local debugger_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/vscode-js-debug"
local debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
local debugger_cmd = { "js-debug-adapter" }

local function setup_vscode_js_debugger()
	dap_vscode_js.setup({
		-- Path of node executable. Defaults to $NODE_PATH, and then "node"
		node_path = node_path,
		-- Path to vscode-js-debug installation.
		debugger_path = debugger_path,
		-- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
		debugger_cmd = debugger_cmd,
		-- which adapters to register in nvim-dap
		adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		-- Path for file logging
		-- log_file_path = vim.fn.stdpath("cache") .. "/dap_vscode_js.log",
		-- Logging level for output to console. Set to false to disable console output.
		-- log_console_level = vim.log.levels.ERROR,
	})
end

function M.show_config()
	print("node_path = " .. node_path)
	print("debugger_path = " .. debugger_path)
	print("debugger_cmd = ")
	Print_all_in_table(debugger_cmd)
	print("dap.configurations.javascript = ")
	Print_all_in_table(dap.configurations.javascript)
	-- PrintTable(dap.configurations.javascript)
	-- print("dap.configurations.typescript = \n")
	-- Print_all_in_table(dap.configurations.typescript)
end

function M.setup()
	-- configure run time environment for DAP of vscode-js-debug
	setup_vscode_js_debugger()
	-- language configurations
	for _, language in ipairs({ "typescript", "javascript" }) do
		dap.configurations[language] = {
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
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch Program",
				program = "${workspaceFolder}/bin/www",
			},
		}
	end
end

return M
