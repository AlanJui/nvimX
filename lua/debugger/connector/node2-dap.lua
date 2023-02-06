-- Node.js Adapter
local dap = _G.safe_require("dap")
if not dap then
	return
end

local M = {}

-- local debug_server_path = os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js"
local debug_server_path = os.getenv("HOME")
	.. "/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"

-- configure DAP Adapter
function M.setup()
	-- dap.set_log_level("TRACE")
	dap.set_log_level("DEBUG")

	dap.adapters.node2 = {
		type = "executable",
		command = "node",
		args = {
			debug_server_path,
		},
	}

	dap.configurations.javascript = {
		{
			name = "Launch File",
			type = "node2",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		},
		{
			-- For this to work you need to make sure the node process is started with the `--inspect` flag.
			name = "Attach to process",
			type = "node2",
			request = "attach",
			processId = require("dap.utils").pick_process,
		},
	}
end

return M
