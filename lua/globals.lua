local path_sep = vim.loop.os_uname().version:match("Windows") and "\\" or "/"

local function file_exists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local function which_os()
    local system_name

    if vim.fn.has("mac") == 1 then
        system_name = "macOS"
    elseif vim.fn.has("unix") == 1 then
        system_name = "Linux"
    elseif vim.fn.has("win32") == 1 then
        system_name = "Windows"
    else
        system_name = ""
    end

    return system_name
end

local function tprint(tbl, indent)
    if not indent then indent = 0 end
    local toprint = string.rep(" ", indent) .. "{\n"
    indent = indent + 2
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if type(k) == "number" then
            toprint = toprint .. "[" .. k .. "] = "
        elseif type(k) == "string" then
            toprint = toprint .. k .. "= "
        end
        if type(v) == "number" then
            toprint = toprint .. v .. ",\n"
        elseif type(v) == "string" then
            toprint = toprint .. '"' .. v .. '",\n'
        elseif type(v) == "table" then
            toprint = toprint .. tprint(v, indent + 2) .. ",\n"
        else
            toprint = toprint .. '"' .. tostring(v) .. '",\n'
        end
    end
    toprint = toprint .. string.rep(" ", indent - 2) .. "}"
    return toprint
end

-----------------------------------------------------------
-- Global Functions
-----------------------------------------------------------
local os_sys = which_os()
local nvim_name = os.getenv("MY_NVIM") or vim.g.my_nvim or "nvim"
local home_dir = os.getenv("HOME")
-- local config_dir = home_dir .. "/.config/" .. nvim_name
-- local config_dir = vim.call("stdpath", "config")
local config_dir = vim.fn.stdpath("config")
-- local runtime_dir = home_dir .. "/.local/share/" .. nvim_name
-- local runtime_dir = vim.call("stdpath", "data")
-- $HOME/.local/share/nvim/
local runtime_dir = vim.fn.stdpath("data")
-- local cache_dir = vim.call("stdpath", "cache")
local cache_dir = vim.fn.stdpath("cache")
local package_root = runtime_dir .. "/site/pack"
local install_path = package_root .. "/packer/start/packer.nvim"
local compile_path = config_dir .. "/plugin/packer_compiled.lua"

local snippets_path = {
    config_dir .. "/my-snippets",
    package_root .. "/packer/start/friendly-snippets",
}

local LSP_SERVERS = {
    "lua_ls",
    "vimls",
    "diagnosticls",
    "pyright",
    "emmet_ls",
    "html",
    "cssls",
    "tailwindcss",
    "tsserver",
    "eslint",
    "jsonls",
    "stylelint_lsp",
    "texlab",
    "bashls",
}

-----------------------------------------------------------
-- 功能：檢查目前的「工作目錄」中是否有 pyproject.toml 檔案，
-- 若有，表：此為目錄為 Python 專案目錄。若目錄下尚有 .venv
-- 子目錄，則再於 .venv 目錄下找 python 直譯器之路徑；若無
-- .venv 目錄，則以「系統環境變數：VIRTUAL_ENV」，推導 python
-- 直譯器的路徑。
--
-- 回傳之返回值共兩個；
-- 第一返回值，資料型態為：boolean，表：有 pyproject.toml
-- 檔存在目前的工作目錄（亦即，這是一個 Python 專案工作目錄）；
--
-- 第二返回值，資料型態為：string ，表 Python Virtual Environment
-- 的 Python 路徑。當第一返回值為 false 時，則第二返回值當為 Null 。
-----------------------------------------------------------
function _G.check_python_project()
    -- 取得當前檔案路徑：vim.fn.expand('%:p') 取得當前檔案的絕對路徑
    -- local current_file_path = vim.fn.expand("%:p")
    -- local dir_path = vim.fn.fnamemodify(current_file_path, ":h")

    -- 取得目錄路徑
    local dir_path = vim.fn.getcwd()

    -- 檢查 pyproject.toml 檔案是否存在
    local pyproject_path = dir_path .. "/pyproject.toml"
    local pyproject_exists = vim.fn.filereadable(pyproject_path)

    if pyproject_exists then
        -- 檢查是否有 .venv 子目錄
        local venv_dir_path = dir_path .. "/.venv"
        local venv_dir_exists = vim.fn.isdirectory(venv_dir_path)

        -- 設定 Python 直譯器路徑
        local python_path = ""
        if venv_dir_exists == 1 then
            python_path = venv_dir_path .. "/bin/python"
        else
            local pyenv_virtual_env = os.getenv("VIRTUAL_ENV") or ""
            if pyenv_virtual_env ~= "" then python_path = pyenv_virtual_env .. "/bin/python" end
        end

        -- 返回結果
        return true, python_path
    else
        return false, nil
    end
end
local is_python_project, venv_python_path = check_python_project()

-----------------------------------------------------------
-- Python environment for NeoVim
-----------------------------------------------------------
local PYENV_ROOT_PATH = home_dir .. "/.pyenv/versions/"
local PYTHON_VERSION = "3.10.6"
local PYTHON_VENV = "venv-" .. PYTHON_VERSION
local PYTHON_BINARY = PYENV_ROOT_PATH .. PYTHON_VERSION .. "/envs/" .. PYTHON_VENV .. "/bin/python"
local debugpy_path = runtime_dir .. "/mason/packages/debugpy/venv/bin/python"
-----------------------------------------------------------
-- Python environment for Project
-----------------------------------------------------------
local pyenv_python_path = ""
local pyenv_virtual_env = os.getenv("VIRTUAL_ENV") or ""
if pyenv_virtual_env ~= "" then pyenv_python_path = pyenv_virtual_env .. "/bin/python" end
local workspace_folder = vim.fn.getcwd()

local get_venv_python_path = function()
    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
    if vim.fn.executable(pyenv_python_path) then
        return pyenv_python_path
    elseif vim.fn.executable(workspace_folder .. "/venv/bin/python") == 1 then
        return workspace_folder .. "/venv/bin/python"
    elseif vim.fn.executable(workspace_folder .. "/.venv/bin/python") == 1 then
        return workspace_folder .. "/.venv/bin/python"
    else
        return "/usr/bin/python"
    end
end

-----------------------------------------------------------
function _G.GetConfig()
    return {
        os = os_sys,
        home = home_dir,
        nvim = nvim_name,
        config = config_dir,
        runtime = runtime_dir,
        cache = cache_dir,
        package_root = package_root,
        install_path = install_path,
        compile_path = compile_path,
        snippets = snippets_path,
        lsp_servers = LSP_SERVERS,
        python = {
            root_path = PYENV_ROOT_PATH,
            nvim_binary = PYTHON_BINARY,
            debugpy_path = debugpy_path,
            venv = pyenv_virtual_env,
            venv_python_path = get_venv_python_path(),
        },
        ------------------------------------------------------------------------------
        -- npm install -g neovim
        ------------------------------------------------------------------------------
        -- debugger_path = runtime_dir .. "/site/pack/packer/opt/vscode-js-debug",
        -- debugger_path = runtime_dir .. "/mason/packages/js-debug-adapter",
        nodejs = {
            node_path = home_dir .. "/n/bin/node",
            node_host_prog = home_dir .. "/n/lib/node_modules/neovim/bin/cli.js",
            debugger_path = home_dir .. "/.local/share/vscode-js-debug",
            debugger_cmd = { "vsDebugServer.js", "js-debug-adapter" },
        },
    }
end

function _G.WhichOS()
    local system_name = which_os()
    return system_name
end

function _G.TableConcat(t1, t2)
    for i = 1, #t2, 1 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

function _G.JoinTwoTable(tbl1, tbl2)
    local new_tbl = {}
    for k, v in pairs(tbl1) do
        new_tbl[k] = v
    end
    for _, v in pairs(tbl2) do
        table.insert(new_tbl, v)
    end

    return new_tbl
end

function _G.print_table(node)
    local cache, stack, output = {}, {}, {}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        ---@diagnostic disable-next-line: unused-local
        for k, v in pairs(node) do -- luacheck: ignore
            size = size + 1
        end

        local cur_index = 1
        for k, v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then
                if string.find(output_str, "}", output_str:len()) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str, "\n", output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output, output_str)
                output_str = ""

                local key
                if type(k) == "number" or type(k) == "boolean" then
                    key = "[" .. tostring(k) .. "]"
                else
                    key = "['" .. tostring(k) .. "']"
                end

                if type(v) == "number" or type(v) == "boolean" then
                    output_str = output_str .. string.rep("\t", depth) .. key .. " = " .. tostring(v)
                elseif type(v) == "table" then
                    output_str = output_str .. string.rep("\t", depth) .. key .. " = {\n"
                    table.insert(stack, node)
                    table.insert(stack, v)
                    cache[node] = cur_index + 1
                    break
                else
                    output_str = output_str .. string.rep("\t", depth) .. key .. " = '" .. tostring(v) .. "'"
                end

                if cur_index == size then
                    output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if cur_index == size then output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}" end
            end

            cur_index = cur_index + 1
        end

        if size == 0 then output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}" end

        if #stack > 0 then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output, output_str)
    output_str = table.concat(output)

    print(output_str)
end

function _G.DumpTable(table)
    for k, v in pairs(table) do
        print("key = ", k, "    value = ", v)
    end
end

function _G.PrintTableWithIndent(table, indent_size) print(tprint(table, indent_size)) end

function _G.PrintTable(table) _G.print_table(table) end

function _G.IsDirNotExist(dir_path)
    if file_exists(dir_path) == true then
        return true
    else
        return false
    end
end

function _G.IsFileExist(path)
    if file_exists(path) == true then
        return true
    else
        return false
    end
end

function _G.Is_packer_nvim_installed()
    local installed = false
    if vim.fn.empty(vim.fn.glob(install_path)) == 0 then installed = true end
    return installed
end

function _G.is_empty(str) return str == nil or str == "" end

-----------------------------------------------------------------------------
-- Exampe: JoinPaths("a", "b", "c") => "a/b/c"
-----------------------------------------------------------------------------
function _G.JoinPaths(...)
    local result = table.concat({ ... }, path_sep)
    return result
end

function _G.is_git_dir() return os.execute("git rev-parse --is-inside-work-tree >> /dev/null 2>&1") end

function _G.get_home_dir() return os.getenv("HOME") end

function _G.GetHomeDir() return os.getenv("HOME") end

function _G.P(cmd) print(vim.inspect(cmd)) end

function _G.get_rtp() print(string.format("rtp = %s", vim.opt.rtp["_value"])) end

function _G.safe_require(module)
    local ok, result = pcall(require, module)
    if not ok then
        -- vim.notify(string.format("Plugin not installed: %s", module), vim.log.levels.ERROR)
        vim.notify(string.format("Plugin not installed: %s", module), vim.log.levels.WARN)
        return ok
    end
    return result
end

function _G.ShowNodejsDAP()
    local dap = require("dap")

    print("dap.configurations.javascript = \n")
    _G.PrintTable(dap.configurations.javascript)
    print("dap.configurations.typescript = \n")
    _G.PrintTable(dap.configurations.typescript)
end
