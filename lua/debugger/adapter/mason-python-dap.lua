local dap = _G.safe_require("dap")
local mason_nvim_dap = _G.safe_require("mason-nvim-dap")
if not dap or not mason_nvim_dap then
	return
end

local M = {}

local nvim_config = _G.GetConfig()
local debugpy_path = nvim_config["python"]["debugpy_path"]
local venv_python_path = nvim_config["python"]["venv_python_path"]

function M.setup()
	mason_nvim_dap.setup_handlers({
		python = function(_source_name) --luacheck: ignore 212
			dap.adapters.python = {
				type = "executable",
				command = debugpy_path,
				args = {
					"-m",
					"debugpy.adapter",
				},
			}

			dap.configurations.python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}", -- This configuration will launch the current file if used.
					pythonPath = venv_python_path,
				},
				{
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
					pythonPath = venv_python_path,
				},
			}
		end,
	})
end

return M
