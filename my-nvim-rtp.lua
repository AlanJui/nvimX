------------------------------------------------------------------------------
-- Setup Neovim Run Time Path
-- 設定 RTP ，要求 Neovim 啟動時的設定作業、執行作業，不採預設。
-- 故 my-nvim 的設定檔，可置於目錄： ~/.config/my-nvim/ 運行；
-- 執行作業（Run Time）所需使用之擴充套件（Plugins）與 LSP Servers
-- 可置於目錄： ~/.local/share/my-nvim/
------------------------------------------------------------------------------

-- 若 MY_VIM 設定值，非 Neovim 預設之 `nvim` ；則需變更 Neovim RTP 。
local my_nvim = os.getenv("MY_NVIM") or vim.g.my_nvim or "nvim"
local is_debug = os.getenv("DEBUG") or false

local home_dir = os.getenv("HOME")
local config_dir = home_dir .. "/.config/" .. my_nvim
local runtime_dir = home_dir .. "/.local/share/" .. my_nvim

------------------------------------------------------------------------------
local function join_paths(...)
    local PATH_SEPERATOR = vim.loop.os_uname().version:match("Windows") and "\\" or "/"
    local result = table.concat({ ... }, PATH_SEPERATOR)
    return result
end

local function print_rtp()
    print("-----------------------------------------------------------")
    -- P(vim.api.nvim_list_runtime_paths())
    local rtp_table = vim.opt.runtimepath:get()
    for k, v in pairs(rtp_table) do
        print("key = ", k, "    value = ", v)
    end
end

local function setup_run_time_path()
    -- 變更kstdpath('config') 預設的 rtp : ~/.config/nvim/
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath("data"), "site"))
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath("data"), "site", "after"))
    vim.opt.rtp:prepend(join_paths(runtime_dir, "site"))
    vim.opt.rtp:append(join_paths(runtime_dir, "site", "after"))

    -- 變更 stdpath('data') 預設的 rtp : ~/.local/share/my-nvim/
    vim.opt.rtp:remove(vim.fn.stdpath("config"))
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath("config"), "after"))
    vim.opt.rtp:prepend(config_dir)
    vim.opt.rtp:append(join_paths(config_dir, "after"))

    -- 引用 rpt 設定 package path （即擴充擴件(plugins)的安裝路徑）
    -- 此設定需正確，指令：requitre('<PluginName>') 才能正常執行。
    vim.cmd([[let &packpath = &runtimepath]])
end

---------------------------------------------------------------------
-- Main Process
---------------------------------------------------------------------

if my_nvim ~= "nvim" then
    -- 在「除錯」作業時，顯示 setup_rtp() 執行前、後， rtp 的設定內容。
    if is_debug then
        print_rtp()
    end

    -- change Neovm default RTP
    setup_run_time_path()

    if is_debug then
        print_rtp()
    end
end
