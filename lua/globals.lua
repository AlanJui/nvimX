local path_sep = vim.loop.os_uname().version:match("Windows") and "\\" or "/"

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

local function which_os()
	local system_name

	if vim.fn.has("mac") == 1 then
		system_name = "macOS"
	elseif vim.fn.has("unix") == 1 then
		system_name = "Linux"
	elseif vim.fn.has("win32") == 1 then
		system_name = "Windows"
	else
		system_name = ""
	end

	return system_name
end

local function tprint(tbl, indent)
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if type(k) == "number" then
			toprint = toprint .. "[" .. k .. "] = "
		elseif type(k) == "string" then
			toprint = toprint .. k .. "= "
		end
		if type(v) == "number" then
			toprint = toprint .. v .. ",\n"
		elseif type(v) == "string" then
			toprint = toprint .. '"' .. v .. '",\n'
		elseif type(v) == "table" then
			toprint = toprint .. tprint(v, indent + 2) .. ",\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

-----------------------------------------------------------
-- Global Functions
-----------------------------------------------------------
local os_sys = which_os()
local nvim_name = os.getenv("MY_NVIM") or vim.g.my_nvim or "nvim"
local home_dir = os.getenv("HOME")
-- local config_dir = home_dir .. "/.config/" .. nvim_name
local config_dir = vim.call("stdpath", "config")
-- local runtime_dir = home_dir .. "/.local/share/" .. nvim_name
local runtime_dir = vim.call("stdpath", "data")
local cache_dir = vim.call("stdpath", "cache")
local package_root = runtime_dir .. "/site/pack"
local install_path = package_root .. "/packer/start/packer.nvim"
local compile_path = config_dir .. "/plugin/packer_compiled.lua"

local snippets_path = {
	config_dir .. "/my-snippets",
	package_root .. "/packer/start/friendly-snippets",
}

local LSP_SERVERS = {
	"vimls",
	"sumneko_lua",
	-- "diagnosticls",
	"pyright",
	"emmet_ls",
	"html",
	"cssls",
	"tailwindcss",
	"stylelint_lsp",
	"eslint",
	"jsonls",
	"tsserver",
	"texlab",
}
-----------------------------------------------------------
-- Python environment for NeoVim
-----------------------------------------------------------
local PYENV_ROOT_PATH = home_dir .. "/.pyenv/versions/"
local PYTHON_VERSION = "3.10.6"
local PYTHON_VENV = "venv-" .. PYTHON_VERSION
local PYTHON_BINARY = PYENV_ROOT_PATH .. PYTHON_VERSION .. "/envs/" .. PYTHON_VENV .. "/bin/python"
local debugpy_path = runtime_dir .. "/mason/packages/debugpy/venv/bin/python"
-----------------------------------------------------------
-- Python environment for Project
-----------------------------------------------------------
local pyenv_virtual_env = os.getenv("VIRTUAL_ENV")
local pyenv_python_path = pyenv_virtual_env .. "/bin/python"
local workspace_folder = vim.fn.getcwd()

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

-----------------------------------------------------------
function _G.GetConfig()
	return {
		os = os_sys,
		home = home_dir,
		nvim = nvim_name,
		config = config_dir,
		runtime = runtime_dir,
		cache = cache_dir,
		package_root = package_root,
		install_path = install_path,
		compile_path = compile_path,
		snippets = snippets_path,
		lsp_servers = LSP_SERVERS,
		python = {
			root_path = PYENV_ROOT_PATH,
			nvim_binary = PYTHON_BINARY,
			debugpy_path = debugpy_path,
			venv = pyenv_virtual_env,
			venv_python_path = get_venv_python_path(),
		},
		------------------------------------------------------------------------------
		-- npm install -g neovim
		------------------------------------------------------------------------------
		-- debugger_path = runtime_dir .. "/site/pack/packer/opt/vscode-js-debug",
		-- debugger_path = runtime_dir .. "/mason/packages/js-debug-adapter",
		nodejs = {
			node_path = home_dir .. "/n/bin/node",
			node_host_prog = home_dir .. "/n/lib/node_modules/neovim/bin/cli.js",
			debugger_path = home_dir .. "/.local/share/vscode-js-debug",
			debugger_cmd = { "vsDebugServer.js", "js-debug-adapter" },
		},
	}
end

function _G.WhichOS()
	local system_name = which_os()
	return system_name
end

function _G.print_table(table)
	for index, data in ipairs(table) do
		print(index)

		for key, value in pairs(data) do
			print(string.format("key = %s, value = %s", key, value))
		end
	end
end

function _G.PrintTable(table)
	for k, v in pairs(table) do
		print("key = ", k, "    value = ", v)
	end
end

function _G.PrintTableWithIndent(table, indent_size)
	print(tprint(table, indent_size))
end

function _G.Print_all_in_table(table, indent_size)
	print(tprint(table, indent_size))
end

function _G.IsDirNotExist(dir_path)
	if file_exists(dir_path) == true then
		return true
	else
		return false
	end
end

function _G.IsFileExist(path)
	if file_exists(path) == true then
		return true
	else
		return false
	end
end

function _G.Is_packer_nvim_installed()
	local installed = false
	if vim.fn.empty(vim.fn.glob(install_path)) == 0 then
		installed = true
	end
	return installed
end

function _G.is_empty(str)
	return str == nil or str == ""
end

-----------------------------------------------------------------------------
-- Exampe: JoinPaths("a", "b", "c") => "a/b/c"
-----------------------------------------------------------------------------
function _G.JoinPaths(...)
	local result = table.concat({ ... }, path_sep)
	return result
end

function _G.is_git_dir()
	return os.execute("git rev-parse --is-inside-work-tree >> /dev/null 2>&1")
end

function _G.get_home_dir()
	return os.getenv("HOME")
end

function _G.GetHomeDir()
	return os.getenv("HOME")
end

function _G.P(cmd)
	print(vim.inspect(cmd))
end

function _G.get_rtp()
	print(string.format("rtp = %s", vim.opt.rtp["_value"]))
end

function _G.safe_require(module)
	local ok, result = pcall(require, module)
	if not ok then
		-- vim.notify(string.format("Plugin not installed: %s", module), vim.log.levels.ERROR)
		vim.notify(string.format("Plugin not installed: %s", module), vim.log.levels.WARN)
		return ok
	end
	return result
end

function _G.ShowNodejsDAP()
	local dap = require("dap")

	print("dap.configurations.javascript = \n")
	_G.Print_all_in_table(dap.configurations.javascript)
	print("dap.configurations.typescript = \n")
	_G.Print_all_in_table(dap.configurations.typescript)
end
