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

if not dap or not dapui or not mason_nvim_dap then return end

local function setup_debugger_icons()
  vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "", linehl = "", numhl = "" })
end

-- 設定「除錯接合器」在「使用者介面（UI）」的配置及監控事件
local function setup_debugger_ui()
  -- 設定「除錯接合器（Debug Adapter）」，可顯示「變數」內容值。
  require("nvim-dap-virtual-text").setup({ commented = true })

  -- 設定「除錯器」的「使用者介面」在「右側」顯示
  dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
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
    controls = {
      enabled = true,
      element = "repl",
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "",
        run_last = "",
        terminate = "",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = { close = { "q", "<Esc>" } },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil, -- Can be integer or nil.
    },
  })

  -- 完成「初始作業」後，便顯示使用者介面
  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end

  -- 值「終結作業」時，便關閉使用者介面
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end

  -- 值「結束作業」時，便關閉使用者介面
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
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

local venv_python_path = get_venv_python_path()
-- local debugpy_python_path = "/usr/bin/python3"
local debugpy_python_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"

local handlers = {
  function(config) require("mason-nvim-dap").default_setup(config) end,
  python = function() --luacheck: ignore 212
    dap.adapters.python = {
      type = "executable",
      command = debugpy_python_path,
      args = {
        "-m",
        "debugpy.adapter",
      },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = venv_python_path,
      },
      {
        type = "python",
        request = "launch",
        name = "Launch Django Server",
        cwd = "${workspaceFolder}",
        program = "${workspaceFolder}/manage.py",
        args = {
          "runserver",
          "--noreload",
        },
        console = "integratedTerminal",
        justMyCode = true,
        pythonPath = venv_python_path,
      },
      {
        type = "python",
        request = "launch",
        name = "Python: Django Debug Single Test",
        program = "${workspaceFolder}/manage.py",
        args = {
          "test",
          "${relativeFileDirname}",
        },
        django = true,
        console = "integratedTerminal",
        pythonPath = venv_python_path,
        -- pythonPath = "${workspaceFolder}/.venv/bin/python",
      },
    }
  end,
}

-- 各程式語言所用之「除錯接合器」載入作業
-- 手動下載程式語言專屬之 DAP：
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
local function load_language_specific_dap()
  -- Python Language
  require("debugger/adapter/python").setup()

  -- Lua language
  require("debugger/adapter/lua").setup()

  -- Node.js
  require("debugger/adapter/node2").setup()
end

-----------------------------------------------------------
-- Main processes
-----------------------------------------------------------

setup_debugger_icons()
setup_debugger_ui()
load_language_specific_dap()

mason_nvim_dap.setup({
  ensure_installed = { "stylua", "jq", "debugpy" },
  handlers = handlers,
})

-- DAP 操作之各項「操作指令」，於 which_key 中之 "debug" 指令選單中設定。
require("debugger/keymaps").setup()
