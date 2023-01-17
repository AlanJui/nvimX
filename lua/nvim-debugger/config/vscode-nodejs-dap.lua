local M = {}

function M.setup()
	require("dap-vscode-js").setup({
		-- Path of node executable. Defaults to $NODE_PATH, and then "node"
		-- node_path = "node",
		node_path = "/usr/local/bin/node",
		-- Path to vscode-js-debug installation.
		-- debugger_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/vscode-js-debug",
		debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
		-- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
		debugger_cmd = { "js-debug-adapter" },
		-- which adapters to register in nvim-dap
		adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		-- Path for file logging
		log_file_path = vim.fn.stdpath("cache") .. "/dap_vscode_js.log",
		-- Logging level for output to console. Set to false to disable console output.
		log_console_level = vim.log.levels.ERROR,
	})

	for _, language in ipairs({ "typescript", "javascript" }) do
		require("dap").configurations[language] = {
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
		}
	end
end

return M
