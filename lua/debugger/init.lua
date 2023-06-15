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
local dap = safe_require("dap")
local mason_nvim_dap = safe_require("mason-nvim-dap")
local dapui = safe_require("dapui")

if not dap or not dapui or not mason_nvim_dap then
  print("mason-nvim-dap: dap or dapui or mason_nvim_dap is not loaded!")
  return
end

local function setup_debugger_icons()
  -- vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
  -- vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })
  -- vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
  -- vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "", linehl = "", numhl = "" })
  -- vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "", linehl = "", numhl = "" })
  local icons = require("icons")
  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

  for name, sign in pairs(icons.dap) do
    sign = type(sign) == "table" and sign or { sign }
    vim.fn.sign_define("Dap" .. name, {
      text = sign[1],
      texthl = sign[2] or "DiagnosticInfo",
      linehl = sign[3],
      numhl = sign[3],
    })
  end
end

-- 設定「除錯接合器」在「使用者介面（UI）」的配置及監控事件
local function setup_debugger_ui()
  -- 設定「除錯接合器（Debug Adapter）」，可顯示「變數」內容值。
  require("nvim-dap-virtual-text").setup({
    commented = true,
  })

  -- 設定「除錯器」的「使用者介面」在「右側」顯示
  dapui.setup({
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.25 },
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40, -- 40 columns
        position = "left",
      },
      {
        elements = { "repl", "console" },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
    },
  })

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
end

-----------------------------------------------------------
-- It's important that you set up the plugins in the following order:
--
--   1. mason.nvim
--   2. mason-nvim-dap.nvim
--
-- Pay extra attention to this if you're using a plugin manager to load plugins for you,
-- as there are no guarantees it'll load plugins in the correct order unless explicitly
-- instructed to.
-----------------------------------------------------------

local function get_venv_python_path()
  local workspace_folder = vim.fn.getcwd()

  if vim.fn.executable(workspace_folder .. "/.venv/bin/python") then
    return workspace_folder .. "/.venv/bin/python"
  elseif vim.fn.executable(workspace_folder .. "/venv/bin/python") then
    return workspace_folder .. "/venv/bin/python"
  elseif vim.fn.executable(os.getenv("VIRTUAL_ENV") .. "/bin/python") then
    return os.getenv("VIRTUAL_ENV" .. "/bin/python")
  else
    return "/usr/bin/python"
  end
end

-- 各程式語言所用之「除錯接合器」載入作業
-- 手動下載程式語言專屬之 DAP：
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
local function load_language_specific_dap()
  -- Python Language
  require("debugger/adapter/python").setup()

  -- Lua language
  require("debugger/adapter/lua").setup()

  -- Node.js
  -- require("debugger/adapter/node2").setup()
  require("debugger/adapter/javascript").setup()
end

-----------------------------------------------------------
-- Main processes
-----------------------------------------------------------

-- 透過 Mason 安裝 DAP
mason_nvim_dap.setup({
  ensure_installed = {
    -- Python Debugger: "debugpy"
    "python",
    -- Node.js Debugger: "node-debug2-adapter"
    "node2",
    -- JavaScript Debugger: "js-debug-adapter"
    "js",
  },
})

-- 設定除錯器使用者操作介面及應監視操作事件
setup_debugger_icons()
setup_debugger_ui()
-- 載入各除錯接合器
load_language_specific_dap()

-- 設定除錯器使用之操作按鍵（Which Key）
require("debugger/keymaps").setup()
