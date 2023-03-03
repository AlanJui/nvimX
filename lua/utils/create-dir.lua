local api = vim.api

local function run_shell_command(command)
    -- local command = "ls -l"
    local output = vim.fn.system(command)
    print(output)
end

local function create_directory()
    local default_path = vim.fn.getcwd()
    local dir_name = vim.fn.input("Enter directory name: ", default_path)
    if dir_name ~= "" then
        local cmd = "mkdir " .. vim.fn.shellescape(dir_name)
        -- os.execute(cmd)
        run_shell_command(cmd)
        print("Directory '" .. dir_name .. "' created")
    end
end

return {
    create_directory = create_directory,
}
