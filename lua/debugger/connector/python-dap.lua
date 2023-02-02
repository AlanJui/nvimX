local dap_python = _G.safe_require("dap-python")
if not dap_python then
	return
end

local M = {}

local dap = require("dap")

local nvim_config = _G.GetConfig()
local debug_server_path = nvim_config["python"]["debugpy_path"]
local python_path = nvim_config["python"]["venv_python_path"]

local python_config = {
	type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
	request = "launch",
	name = "Launch Python file",
	program = "${file}", -- This configuration will launch the current file if used.
	console = "integratedTerminal",
	pythonPath = python_path,
}

local django_config = {
	type = "python",
	request = "launch",
	name = "Launch Django",
	cwd = "${workspaceFolder}",
	program = "${workspaceFolder}/manage.py",
	args = {
		"runserver",
		"--noreload",
	},
	console = "integratedTerminal",
	justMyCode = true,
	pythonPath = python_path,
}

function M.setup()
	-- configure DAP Adapter
	dap_python.setup(debug_server_path)

	-- configure configurations of dap Adapter
	table.insert(dap.configurations.python, python_config)
	table.insert(dap.configurations.python, django_config)
end

return M
