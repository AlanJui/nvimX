------------------------------------------------------------------
-- 《除錯作業流程》
--
-- （1）設定「中斷點」
--      Setting breakpoints via
--      :lua require'dap'.toggle_breakpoint()
--
-- （2）啟動除錯功能
--      Launching debug sessions and resuming execution via
--      :lua require'dap'.continue()
--
-- （3）逐「指令」執行
--      Stepping through code via
--      :lua require'dap'.setp_over()  and
--      :lua require'dap'.step_into()
--
-- （4）檢查程式碼之執行狀態
--      Inspecting the state via the built-in REPL
--      :lua require'dap'.repl.open()  or
--      using the widget UI
------------------------------------------------------------------
local dap = safe_require('dap')
-- 設定「除錯接合器」在「使用者介面（UI）」的配置及監控事件
local dapui = safe_require "dapui"

if not dap or not dapui then
    return
end

local function setup_style_of_breakpoint()
    -- error
    vim.fn.sign_define("DapBreakpoint", {
        text = "🟥",
        texthl = "LspDiagnosticsSignError",
        linehl = "",
        numhl = "",
    })
    -- stopped
    vim.fn.sign_define("DapStopped", {
        text = "⭐️",
        texthl = "LspDiagnosticsSignInformation",
        linehl = "DiagnosticUnderlineInfo",
        numhl = "LspDiagnosticsSignInformation",
    })
    -- rejected
    vim.fn.sign_define("DapBreakpointRejected", {
        text = "",
        texthl = "LspDiagnosticsSignHint",
        linehl = "",
        numhl = "",
    })
end

local function configure_debug_ui()
    -- 設定「除錯接合器（Debug Adapter）」，可顯示「變數」內容值。
    require('nvim-dap-virtual-text').setup({
        commented = true,
    })

    -- 設定「除錯器」的「使用者介面」在「右側」顯示
    dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has("nvim-0.7"),
        -- Layouts define sections of the screen to place windows.
        -- The position can be "left", "right", "top" or "bottom".
        -- The size specifies the height/width depending on position. It can be an Int
        -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
        -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
        -- Elements are the elements shown in the layout (in order).
        -- Layouts are opened in order so that earlier layouts take priority in window sizing.
        layouts = {
            {
                elements = {
                    -- Elements can be strings or table with id and size keys.
                    { id = "scopes", size = 0.25 },
                    "breakpoints",
                    "stacks",
                    "watches",
                },
                size = 40, -- 40 columns
                position = "left",
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 0.25, -- 25% of total lines
                position = "bottom",
            },
        },
        floating = {
            max_height = nil, -- These can be integers or a float between 0 and 1.
            max_width = nil, -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
        render = {
            max_type_length = nil, -- Can be integer or nil.
        }
    })

    -- 完成「初始作業」後，便顯示使用者介面
    dap.listeners.after.event_initialized['dapui_config'] = function ()
        dapui.open()
    end

    -- 值「終結作業」時，便關閉使用者介面
    dap.listeners.before.event_terminated['dapui_config'] = function ()
        dapui.close()
    end

    -- 值「結束作業」時，便關閉使用者介面
    dap.listeners.before.event_exited['dapui_config'] = function ()
        dapui.close()
    end
end

-- 各程式語言所用之「除錯接合器」載入作業
-- 手動下載程式語言專屬之 DAP：
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
local function load_language_specific_dap()

    -- Python Language
    -- require('dap-debug.dap.django').setup(dap)
    require('dap-debug.dap.python').setup(dap)

    -- Lua language
    require('dap-debug.dap.lua').setup(dap)

    -- local dap_config = {
    --     python = require('dap-debug.dap-python'),
    --     lua = require('dap-debug.dap-lua'),
    -- }
    -- for dap_name, dap_options in pairs(dap_config) do
    --     dap.adapters[dap_name] = dap_options.adapters
    --     dap.configurations[dap_name] = dap_options.configurations
    -- end
end

-----------------------------------------------------------
-- Main processes
-----------------------------------------------------------

setup_style_of_breakpoint()
load_language_specific_dap()
configure_debug_ui()

-- DAP 操作之各項「操作指令」，於 which_key 中之 "debug" 指令選單中設定。
-- 設定【快捷鍵】
vim.cmd([[
nnoremap <silent> <F4>  <cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <F5>  <cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F9>  <cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F10> <cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <cmd>lua require'dap'.step_out()<CR>
]])

