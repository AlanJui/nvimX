-----------------------------------------------------------
-- nvim-dap-python
-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
-----------------------------------------------------------

local dap_python = safe_require('dap-python')
if not dap_python then
    return
end

M = {}

-- configure DAP Adapter
M.setup = function (dap)

    -- adapter definition
    dap.adapters.python = ({
        type = 'executable',
        command = 'python',
        args = { '-m', 'debugpy.adapter' }
    })

    -- configurations definitions
    dap.configurations.python = ({
        {
            -- The first three options are required by nvim-dap
            type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = 'launch',
            name = "Launch file",

            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
            program = "${file}", -- This configuration will launch the current file if used.
            pythonPath = function()
                return DEBUGPY
            end,
        },
    })

    table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = vim.fn.getcwd() .. '/manage.py',
        args = { 'runserver', '--noreload' },
    })
end

return M
