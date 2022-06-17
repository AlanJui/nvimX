-- one-small-step-for-vimkind

return {
    adapters = {
        type = "",
        command = "",
        args = { "", }
    },
    configurations = {
        {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance",
            host = function ()
                local value = vim.fn.input('Host [127.0.0.1]: ')
                if value ~= "" then
                    return value
                end
                return '127.0.0.1'
            end,
            port = function ()
                local val = tonumber(vim.fn.input('Port: '))
                assert(val, "Please provide a port number")
                return val
            end,
        }
    },
}
