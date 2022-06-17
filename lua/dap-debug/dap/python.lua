local dap_python = safe_require('dap-python')
if not dap_python then
    return
end

M = {}

M.setup = function (dap)
    -- configure DAP Adapter
    local python_path = DEBUGPY
    require('dap-python').setup(python_path)

    table.insert(dap.configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Django',
        program = vim.fn.getcwd() .. '/manage.py',
        args = { 'runserver', '--noreload' },
    })
end

return M
