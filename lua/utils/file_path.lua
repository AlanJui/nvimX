local M = {}

local path_sep = vim.loop.os_uname().version:match("Windows") and "\\" or "/"

local home_dir = os.getenv("HOME")
local config_dir = vim.fn.stdpath("config")
local runtime_dir = vim.fn.stdpath("data")

M.file_exists = function(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

M.is_empty = function(str)
  return str == nil or str == ""
end

-- M.join_paths = function(...)
--   local result = table.concat = function({ ... }, path_sep)
--   return result
-- end

M.is_git_dir = function()
  return os.execute("git rev-parse --is-inside-work-tree >> /dev/null 2>&1")
end

M.get_home_dir = function()
  return home_dir
end

M.get_snippets_dir = function()
  local snippets_path = {
    config_dir .. "/my-snippets",
    runtime_dir .. "/lazy/friendly-snippets",
  }
  return snippets_path
end

M.get_rtp = function()
  print(string.format("rtp = %s", vim.opt.rtp["_value"]))
end

M.safe_require = function(module)
  local ok, result = pcall(require, module)
  if not ok then
    -- vim.notify(string.format("Plugin not installed: %s", module), vim.log.levels.ERROR)
    vim.notify(string.format("Plugin not installed: %s", module), vim.log.levels.WARN)
    return ok
  end
  return result
end

return M
