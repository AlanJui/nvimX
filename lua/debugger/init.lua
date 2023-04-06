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
local dap = _G.safe_require("dap")
local neodev = _G.safe_require("neodev")
local dapui = _G.safe_require("dapui")
local mason_nvim_dap = _G.safe_require("mason-nvim-dap")

if not dap or not neodev or not dapui or not mason_nvim_dap then
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

-- 設定操作介面
local function setup_debug_ui()
    -- Use neodev.nvim to enable type checking for nvim-dap-ui to get type checking,
    -- autocompletion, and documentation
    -- To enable type checking for nvim-dap-ui
    neodev.setup({
        libary = {
            plugins = { "nvim-dap-ui" },
            types = true,
        },
    })
    -- 設定「除錯接合器（Debug Adapter）」，可顯示「變數」內容值。
    require("nvim-dap-virtual-text").setup({ commented = true })

    -- 完成「初始作業」後，便顯示使用者介面
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end

    -- 值「終結作業」時，便關閉使用者介面
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end

    -- 值「結束作業」時，便關閉使用者介面
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    -- 設定「除錯器」的「使用者介面」在「右側」顯示
    dapui.setup({ })
end

-- 各程式語言「除錯接合器」載入作業
local function load_language_specific_dap()
    require("debugger/connector/lua-dap").setup()
    -- require("debugger/connector/js-dap").setup()
    -- require("debugger/connector/mason-python-dap").setup()
    -- require("debugger/connector/vscode-nodejs-dap").setup()
end

-----------------------------------------------------------
-- Main processes
-----------------------------------------------------------

-- 務必依如下順序執行
-- require("mason").setup({...})
-- require("mason-nvim-dap").setup({
--     ensure_installed = { ... },
--     automatic_setup = false,
-- })
-- require 'mason-nvim-dap'.setup_handlers({ ... })

--
-- main processes
--
mason_nvim_dap.setup({
    ensure_installed = {
        "python",
        "node2",
        "js",
        "bash",
    },
    automatic_setup = true,
})

mason_nvim_dap.setup_handlers({
    function(source_name)
        -- all sources with no handler get passed here

        -- Keep original functionality of `automatic_setup = true`
        require("mason-nvim-dap.automatic_setup")(source_name)
    end,
    -- python = require("debugger/connector/python-dap").setup(source_name), -- luacheck: ignore
    python = require("debugger/connector/mason-python-dap").setup(),
    node2 = require("debugger/connector/node2-dap").setup(),
})

load_language_specific_dap()
setup_style_of_breakpoint()
setup_debug_ui()
require("debugger/keymaps").setup()
-- print("Debugger module configured!")
