local dap_python = safe_require("dap-python")
if not dap_python then
	return
end

local M = {}

local dap = require("dap")

-- local debug_server_path = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python"
local debug_server_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
local workspace_folder = vim.fn.getcwd()
local pyenv_virtual_env = os.getenv("VIRTUAL_ENV")
local pyenv_python_path = pyenv_virtual_env .. "/bin/python"

local get_venv_python_path = function()
	-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
	-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
	-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
	if vim.fn.executable(pyenv_python_path) then
		return pyenv_python_path
	elseif vim.fn.executable(workspace_folder .. "/venv/bin/python") == 1 then
		return workspace_folder .. "/venv/bin/python"
	elseif vim.fn.executable(workspace_folder .. "/.venv/bin/python") == 1 then
		return workspace_folder .. "/.venv/bin/python"
	else
		return "/usr/bin/python"
	end
end

local python_config = {
	type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
	request = "launch",
	name = "Launch Python file",
	program = "${file}", -- This configuration will launch the current file if used.
	pythonPath = get_venv_python_path(),
}

local django_config = {
	type = "python",
	request = "launch",
	name = "Launch Django",
	-- cwd = '${workspaceFolder}',
	program = "${workspaceFolder}/manage.py",
	args = {
		"runserver",
		"--noreload",
	},
	console = "integratedTerminal",
	justMyCode = true,
	pythonPath = get_venv_python_path(),
}

function M.setup()
	-- configure DAP Adapter
	dap_python.setup(debug_server_path)

	-- configure configurations of dap Adapter
	table.insert(dap.configurations.python, python_config)
	table.insert(dap.configurations.python, django_config)
end

return M
