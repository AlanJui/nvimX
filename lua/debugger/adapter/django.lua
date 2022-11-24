-----------------------------------------------------------
-- nvim-dap-python
-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-----------------------------------------------------------
local dap_python = safe_require('dap-python')
if not dap_python then
    return
end

M = {}

M.setup = function (dap)
    -- configure DAP Adapter
    dap.adapters.python = {
        type = 'executable',
        command = 'python',
        args = { '-m', 'debugpy.adapter' },
    }

    -- configure configurations of DAP Adapter
    dap.configurations.python = {
        {
            type = 'python',
            request = 'launch',
            name = 'DAP Django',
            -- cwd = '${workspaceFolder}',
            program = '${workspaceFolder}/manage.py',
            args = {
                'runserver',
                '--noreload',
            },
            console = 'integratedTerminal',
            justMyCode = true,
            pythonPath = function ()
                return DEBUGPY
            end,
        },
    }
end

return M
