-- python3 -m pip install debugpy


return {
    adapters = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" }
    },
    configurations = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            python = function ()
                local venv = os.getenv("VIRTUAL_ENV")
                local python_path = vim.fn.getcwd() .. string.format("%s/bin/python",venv)
                return python_path
            end
        }
    },
}
