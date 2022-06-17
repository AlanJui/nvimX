local is_empty = require('utils').is_empty

local M = {}

-- local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local ENV_HOME = os.getenv('HOME')
local ENV_NVIM = os.getenv('MY_NVIM')
local ENV_CONFIG_DIR  = os.getenv('MY_CONFIG_DIR')
local ENV_RUNTIME_DIR = os.getenv('MY_RUNTIME_DIR')
local package_root, nvim_config_path
local compile_path
local install_path

if (not is_empty(ENV_NVIM) and
    not is_empty(ENV_CONFIG_DIR) and
    not is_empty(ENV_RUNTIME_DIR) )then
    package_root = ENV_RUNTIME_DIR .. '/site/pack'
    nvim_config_path = ENV_CONFIG_DIR
else
    package_root = ENV_HOME .. '/.local/share/' .. MY_VIM .. '/site/pack'
    nvim_config_path =  ENV_HOME .. '/.config/' .. MY_VIM
end

compile_path = nvim_config_path .. '/plugin/packer_compiled.lua'

-- Neovim defualt install path
-- local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
install_path = package_root .. '/packer/start/packer.nvim'

M.get_system = function ()
    local system_name

    if vim.fn.has("mac") == 1 then
        system_name = "macOS"
    elseif vim.fn.has("unix") == 1 then
        system_name = "Linux"
    elseif vim.fn.has('win32') == 1 then
        system_name = "Windows"
    else
        -- Unsupported system
        system_name = ''
    end

    return system_name
end

M.print_rtp = function (pr)
    -- print('rtp=', vim.opt.rtp['_value'])
    print(string.format('rtp = %s', vim.opt.rtp['_value']))
end

M.get_config_dir = function ()
    -- local config_dir = os.getenv('MY_CONFIG_DIR') .. '/nvim'
    return ENV_CONFIG_DIR
end

M.get_runtime_dir = function ()
    -- local runtime_dir = os.getenv('MY_RUNTIME_DIR') .. '/nvim'
    return ENV_RUNTIME_DIR
end

M.get_home = function ()
    return ENV_HOME
end

M.get_package_root = function ()
    return package_root
end

M.get_compile_path = function ()
    return compile_path
end

M.get_install_path = function ()
    return install_path
end

return M
