-----------------------------------------------------------
-- nvim-dap-python
-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-----------------------------------------------------------
M = {}

M.setup = function (python_path)
    local dap_python = safe_require('dap-python')
    if not dap_python then
        return
    end

    -- configure DAP Adapter
    local dap = require('dap')
    dap.adapters.python = {
        type = 'executable';
        command = python_path;
        args = { '-m', 'debugpy.adapter' };
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
                return python_path
            end,
        },
    }
end

return M
