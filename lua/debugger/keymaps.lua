local ok, which_key = pcall(require, "which-key")
if not ok then
    print("which-key not loaded")
    return
end

local M = {}

local keymap = {
    -- Debug
    d = {
        name = "Debug",
        l = {
            name = "Lua",
            s = {
                [[ :lua require("osv").launch({ port = 8086 })<CR> ]],
                [[ Start Lua Debug Server to attach ]],
            },
            l = {
                [[ :lua require("osv").run_this()<CR> ]],
                [[ Launch file (run_this()) ]],
            },
        },
        t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        b = {
            "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
            "Toggle breakpoint",
        },
        B = {
            "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition<cmd> '))<CR>",
            "Condition breakpoint",
        },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
        i = { "<cmd>lua require'dap'.step_into()<CR>", "Step into" },
        o = { "<cmd>lua require'dap'.step_over()<CR>", "Step over" },
        O = { "<cmd>lua require'dap'.step_out()<CR>", "Step out" },
        p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
        g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        Q = {
            "<cmd>lua require'dap'.close()<CR><cmd>lua require'dap.repl'.close()<CR><cmd>lua require'dapui'.close()<CR><cmd>DapVirtualTextForceRefresh<CR>",
            "Quit Nvim DAP",
        },
        -- Show contents in Variable when mouse pointer hover
        h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
        u = { "<cmd>lua require'dapui'.toggle()<CR>", "Show/Hide Debug Sidebar" },
        V = {
            "<cmd>lua local widgets=require'dap.ui.widgets'; widgets.centered_float(widgets.scopes)<CR>",
            "Use widgets to display the variables",
        },
        -- REPEL
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    },
}

local keymap2 = {
    d = {
        name = "Debug",
        R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
        E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
        C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
        U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
        b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
        e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
        g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
        h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
        S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
        q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
        s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
        t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
        u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        l = {
            name = "Lua",
            s = {
                [[ :lua require("osv").launch({ port = 8086 })<CR> ]],
                [[ Start Lua Server in the debuggee ]],
            },
            l = {
                [[ :lua require("osv").run_this()<CR> ]],
                [[ Launch Lua file ]],
            },
        },
    },
}

local keymap_v = {
    name = "Debug",
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
}

function M.setup()
    which_key.register(keymap, {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
    })

    which_key.register(keymap_v, {
        mode = "v",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = false,
    })
end

return M
