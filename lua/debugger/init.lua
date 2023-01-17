------------------------------------------------------------------
-- 《除錯作業流程》
--
-- （1）設定「中斷點」
--      Setting breakpoints via
--      :lua require'dap'.toggle_breakpoint()
--
-- （2）啟動除錯功能
--      Launching debug sessions and resuming execution via
--      :lua require'dap'.continue()
--
-- （3）逐「指令」執行
--      Stepping through code via
--      :lua require'dap'.setp_over()  and
--      :lua require'dap'.step_into()
--
-- （4）檢查程式碼之執行狀態
--      Inspecting the state via the built-in REPL
--      :lua require'dap'.repl.open()  or
--      using the widget UI
------------------------------------------------------------------
local dap = safe_require("dap")
-- local mason_nvim_dap = safe_require("mason-nvim-dap")
-- 設定「除錯接合器」在「使用者介面（UI）」的配置及監控事件
local dapui = safe_require("dapui")

if not dap or not dapui then
	return
end

local function setup_style_of_breakpoint()
	-- error
	vim.fn.sign_define("DapBreakpoint", {
		text = "🟥",
		texthl = "LspDiagnosticsSignError",
		linehl = "",
		numhl = "",
	})
	-- stopped
	vim.fn.sign_define("DapStopped", {
		text = "⭐️",
		texthl = "LspDiagnosticsSignInformation",
		linehl = "DiagnosticUnderlineInfo",
		numhl = "LspDiagnosticsSignInformation",
	})
	-- rejected
	vim.fn.sign_define("DapBreakpointRejected", {
		text = "",
		texthl = "LspDiagnosticsSignHint",
		linehl = "",
		numhl = "",
	})
end

local function configure_debug_ui()
	-- 設定「除錯接合器（Debug Adapter）」，可顯示「變數」內容值。
	require("nvim-dap-virtual-text").setup({ commented = true })

	-- 設定「除錯器」的「使用者介面」在「右側」顯示
	dapui.setup({
		icons = { expanded = "▾", collapsed = "▸" },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		-- Expand lines larger than the window
		-- Requires >= 0.7
		expand_lines = vim.fn.has("nvim-0.7"),
		-- Layouts define sections of the screen to place windows.
		-- The position can be "left", "right", "top" or "bottom".
		-- The size specifies the height/width depending on position. It can be an Int
		-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
		-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
		-- Elements are the elements shown in the layout (in order).
		-- Layouts are opened in order so that earlier layouts take priority in window sizing.
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					{ id = "scopes", size = 0.25 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40, -- 40 columns
				position = "left",
			},
			{
				elements = { "repl", "console" },
				size = 0.25, -- 25% of total lines
				position = "bottom",
			},
		},
		controls = {
			-- Requires Neovim nightly (or 0.8 when released)
			enabled = true,
			-- Display controls in this element
			element = "repl",
			icons = {
				pause = "",
				play = "",
				step_into = "",
				step_over = "",
				step_out = "",
				step_back = "",
				run_last = "",
				terminate = "",
			},
		},
		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			border = "single", -- Border style. Can be "single", "double" or "rounded"
			mappings = { close = { "q", "<Esc>" } },
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil, -- Can be integer or nil.
		},
	})

	-- 完成「初始作業」後，便顯示使用者介面
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end

	-- 值「終結作業」時，便關閉使用者介面
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end

	-- 值「結束作業」時，便關閉使用者介面
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

-- 各程式語言所用之「除錯接合器」載入作業
-- 手動下載程式語言專屬之 DAP：
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
local function load_language_specific_dap(arg_dap)
	-- Python Language
	require("debugger/adapter/python").setup(arg_dap)

	-- Lua language
	require("debugger/adapter/lua").setup(arg_dap)

	-- Node.js
	require("debugger/adapter/node2").setup(arg_dap)
	-- require("debugger/adapter/nodejs").setup(arg_dap)
end

------------------------------------------------

local function dap_automatic_setup()
	-- mason_nvim_dap.setup_handlers({
	require("mason-nvim-dap").setup_handlers({
		function(source_name)
			-- all sources with no handler get passed here

			-- Keep original functionality of `automatic_setup = true`
			-- mason_nvim_dap.automatic_setup(source_name)
			require("mason-nvim-dap.automatic_setup")(source_name)
		end,
		python = function(source_name)
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

			-- local debugpy_path = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python"
			local debugpy_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
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
					name = "Launch Python file",
					program = "${file}", -- This configuration will launch the current file if used.
					pythonPath = get_venv_python_path(),
				},
				{
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
					justMyCode = false,
					pythonPath = get_venv_python_path(),
				},
			}
		end,
		node2 = function(source_name)
			local debug_server_path = os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js"
			-- local debug_server_path = vim.fn.stdpath("data")
			-- .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"

			dap.adapters.node2 = {
				type = "executable",
				command = "node",
				args = {
					debug_server_path,
				},
			}

			dap.configurations.javascript = {
				{
					name = "Launch",
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
		end,
	})
end

-----------------------------------------------------------
-- DAP 操作之各項「操作指令」，於 which_key 中之 "debug" 指令選單中設定。
-- 設定【快捷鍵】
vim.cmd([[
nnoremap <silent> <F4>  <cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <F5>  <cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F9>  <cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F10> <cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <cmd>lua require'dap'.step_out()<CR>
]])
-----------------------------------------------------------
-- Main processes
-----------------------------------------------------------

-- 務必確認以下的設定指令，須依如下順序執行
-- require("mason").setup(...)
-- require("mason-nvim-dap").setup(...),
-- mason_nvim_dap.setup({
-- require("mason-nvim-dap").setup({
-- 	ensure_installed = {
-- 		"python",
-- 		"node2",
-- 	},
-- 	automatic_setup = true,
-- })
-- dap_automatic_setup()
setup_style_of_breakpoint()
configure_debug_ui()
load_language_specific_dap(dap)
