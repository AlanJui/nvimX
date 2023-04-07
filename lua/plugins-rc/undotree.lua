local execute = vim.api.nvim_command
local fn = vim.fn

-- Check if `packer` exists. If not, install it as a start plugin.
local nvim_config = _G.GetConfig()
local undo_path = nvim_config["runtime"] .. "/undo"

if fn.empty(fn.glob(undo_path)) > 0 then
    execute("!mkdir -p " .. undo_path)
end

if vim.fn.has("persistent_undo") == 1 then
    vim.g.undodir = undo_path
    -- vim.cmd("set undofile")
    vim.opt.undodir = undo_path
    vim.opt.undofile = true
end
