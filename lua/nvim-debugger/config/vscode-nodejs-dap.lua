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

local custom_adapter = "pwa-node"

local function setup_vscode_js_debugger()
	dap_vscode_js.setup({
		-- Path of node executable. Defaults to $NODE_PATH, and then "node"
		-- node_path = "node",
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
end

local function custom_debugger_adapter()
	dap.adapters[custom_adapter] = function(cb, config)
		if config.preLaunchTask then
			local async = require("plenary.async")
			local notify = require("notify").async

			async.run(function()
				---@diagnostic disable-next-line: missing-parameter
				notify("Running [" .. config.preLaunchTask .. "]").events.close()
			end, function()
				vim.fn.system(config.preLaunchTask)
				config.type = "pwa-node"
				dap.run(config)
			end)
		end
	end
end

function M.setup()
	-- configure run time environment for DAP of vscode-js-debug
	setup_vscode_js_debugger()
	-- custom debugger adapter for running tasks before starting debug
	-- custom_debugger_adapter()
	-- language configurations
	for _, language in ipairs({ "typescript", "javascript" }) do
		dap.configurations[language] = {
			{
				name = "Launch",
				type = "pwa-node",
				request = "launch",
				program = "${file}",
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				skipFiles = { "<node_internals>/**" },
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				name = "Attach to node process",
				type = "pwa-node",
				request = "attach",
				rootPath = "${workspaceFolder}",
				processId = require("dap.utils").pick_process,
			},
			{
				name = "Debug Main Process (Electron)",
				type = "pwa-node",
				request = "launch",
				program = "${workspaceFolder}/node_modules/.bin/electron",
				args = {
					"${workspaceFolder}/dist/index.js",
				},
				outFiles = {
					"${workspaceFolder}/dist/*.js",
				},
				resolveSourceMapLocations = {
					"${workspaceFolder}/dist/**/*.js",
					"${workspaceFolder}/dist/*.js",
				},
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				skipFiles = { "<node_internals>/**" },
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				name = "Compile & Debug Main Process (Electron)",
				type = custom_adapter,
				request = "launch",
				preLaunchTask = "npm run build-ts",
				program = "${workspaceFolder}/node_modules/.bin/electron",
				args = {
					"${workspaceFolder}/dist/index.js",
				},
				outFiles = {
					"${workspaceFolder}/dist/*.js",
				},
				resolveSourceMapLocations = {
					"${workspaceFolder}/dist/**/*.js",
					"${workspaceFolder}/dist/*.js",
				},
				rootPath = "${workspaceFolder}",
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				skipFiles = { "<node_internals>/**" },
				protocol = "inspector",
				console = "integratedTerminal",
			},
		}
	end
end

return M
