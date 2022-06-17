local M = {}

local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"

function M:get_separator()
    return path_sep
end

function M:is_empty(str)
	return str == nil or str == ''
end

function M:join_paths(...)
    local result = table.concat({ ... }, path_sep)
    return result
end

return M
