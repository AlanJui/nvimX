-----------------------------------------------------------
-- Global Functions
-----------------------------------------------------------
function _G.which_os()
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

function _G.get_home_dir()
	return os.getenv("HOME")
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

function _G.is_empty(str)
	return str == nil or str == ""
end

function _G.is_git_dir()
	return os.execute("git rev-parse --is-inside-work-tree >> /dev/null 2>&1")
end

function P(cmd)
	print(vim.inspect(cmd))
end

function _G.print_table(table)
	for k, v in pairs(table) do
		print("key = ", k, "    value = ", v)
	end
end

function _G.get_rtp()
	print(string.format("rtp = %s", vim.opt.rtp["_value"]))
end
