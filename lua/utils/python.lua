local M = {}

-----------------------------------------------------------
-- Python environment for NeoVim
-----------------------------------------------------------
local PYTHON_VERSION = "3.12.1"
local home_dir = os.getenv("HOME")
local PYENV_ROOT_PATH = home_dir .. "/.pyenv/versions/"

M.get_python_path = function()
  local python_path = PYENV_ROOT_PATH .. PYTHON_VERSION .. "/bin/python"
  return python_path
end

M.get_venv_python_path = function()
  local pyenv_python_path = ""
  local pyenv_virtual_env = os.getenv("VIRTUAL_ENV") or ""
  if pyenv_virtual_env ~= "" then
    pyenv_python_path = pyenv_virtual_env .. "/bin/python"
  end
  local workspace_folder = vim.fn.getcwd()

  if vim.fn.executable(pyenv_python_path) then
    return pyenv_python_path
  elseif vim.fn.executable(workspace_folder .. "/.venv/bin/python") == 1 then
    return workspace_folder .. "/.venv/bin/python"
  elseif vim.fn.executable(workspace_folder .. "/venv/bin/python") == 1 then
    return workspace_folder .. "/venv/bin/python"
  else
    return "/usr/bin/python"
  end
end

M.get_debugpy_path = function()
  local debugpy_path = runtime_dir .. "/mason/packages/debugpy/venv/bin/python"
  return debugpy_path
end

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
--
-- 例如：
-- local is_python_project, venv_python_path = check_python_project()

M.check_python_project = function()
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
      if pyenv_virtual_env ~= "" then
        python_path = pyenv_virtual_env .. "/bin/python"
      end
    end

    -- 返回結果
    return true, python_path
  else
    return false, nil
  end
end

return M
