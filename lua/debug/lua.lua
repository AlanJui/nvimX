-----------------------------------------------------------
-- `one-small-step-for-vimkind` is an adapter for the Neovim
-- lua language. It allows you to debug any lua code running
-- in a Neovim instance.
-----------------------------------------------------------

-- local dap_lua = safe_require('one-small-step-for-vimkind')
-- if not dap_lua then
--     return
-- end

local dap = require("dap")
dap.configurations.lua = {
    {
        type = 'nlua',
        request = 'attach',
        name = "Attach to running Neovim instance",
        host = function()
            -- local value = vim.fn.input('Host [127.0.0.1]: ')
            -- if value ~= "" then
            --     return value
            -- end
            return '127.0.0.1'
        end,
        port = function()
            local val = 54231
            return val
            -- local val = tonumber(vim.fn.input('Port: '))
            -- assert(val, "Please provide a port number")
            -- return val
        end,
    }
}

dap.adapters.nlua = function(callback, config)
    callback({
        type = 'server',
        host = config.host,
        port = config.port
    })
end


-- local dap = require "dap"

-- dap.configurations.lua = {
--     {
--         type = "nlua",
--         request = "attach",
--         name = "Attach to running Neovim instance",
--         host = function() return "127.0.0.1" end,
--         port = function()
--             local val = 54231
--             return val
--         end
--     }
-- }

-- dap.adapters.nlua = function(callback, config)
--     callback({type = 'server', host = config.host, port = config.port})
-- end
