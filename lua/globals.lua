-----------------------------------------------------------
-- Global Functions
-----------------------------------------------------------
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

function Print_all_in_table(table, indent_size)
	print(tprint(table, indent_size))
end

function ShowNodejsDAP()
	local dap = require("dap")

	print("dap.configurations.javascript = \n")
	Print_all_in_table(dap.configurations.javascript)
	print("dap.configurations.typescript = \n")
	Print_all_in_table(dap.configurations.typescript)
end

function PrintTable(table)
	for index, data in ipairs(table) do
		print(index)

		for key, value in pairs(data) do
			print(string.format("key = %s, value = %s", key, value))
		end
	end
	-- for k, v in pairs(table) do
	-- 	print("key = ", k, "    value = ", v)
	-- end
end

function WhichOS()
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

function GetHomeDir()
	return os.getenv("HOME")
end

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
