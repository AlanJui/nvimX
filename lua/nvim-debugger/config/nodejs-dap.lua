local ok = pcall(require, "dap")
if not ok then
	return
end

local M = {}

-- local debug_server_path = os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js"
-- local debug_server_path = vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"
local debug_server_path = vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/node-debug2-adapter"

function M.show_dap_path()
	print("debug_server_path = " .. debug_server_path)
end

-- configure DAP Adapter
function M.setup()
	local nvim_dap = require("dap")

	nvim_dap.adapters.node2 = {
		type = "executable",
		command = "node-debug2-adapter",
		args = {},
	}

	nvim_dap.configurations.javascript = {
		{
			type = "node2",
			name = "Launch",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			-- For this to work you need to make sure the node process is started with the `--inspect` flag.
			type = "node2",
			name = "Attach to process",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
		{
			type = "node2",
			name = "Launch Program with Server Ready",
			request = "launch",
			program = "${workspaceFolder}/bin/www",
			serverReadyAction = {
				pattern = "listening on.* (https? =//\\S+|[0-9]+)",
				uriFormat = "http =//localhost =%s",
				action = "openExternally",
			},
		},
	}
end

return M
