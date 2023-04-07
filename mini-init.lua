-- 設定 tab 空格
vim.cmd([[
set textwidth=120
set nowrap
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
]])
-- ignore default config and plugins
vim.opt.runtimepath:remove(vim.fn.stdpath("config"))
vim.opt.packpath:remove(vim.fn.stdpath("data") .. "/site")
vim.opt.termguicolors = true
vim.opt.laststatus = 0

-- append test directory
local test_dir = "/tmp/nvim-config"
vim.opt.runtimepath:append(vim.fn.expand(test_dir))
vim.opt.packpath:append(vim.fn.expand(test_dir))

-- install packer
local install_path = test_dir .. "/pack/packer/start/packer.nvim"
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    vim.cmd("packadd packer.nvim")
    install_plugins = true
end


local packer = require("packer")

packer.init({
    package_root = test_dir .. "/pack",
    compile_path = test_dir .. "/plugin/packer_compiled.lua",
})

packer.startup(function(use)
    -- Packer can manage itself
    use({"wbthomason/packer.nvim"})

    use({"mfussenegger/nvim-dap"})

    use({
        "rcarriga/nvim-dap-ui",
        requires = "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            dap.adapters.python = {
                type = 'executable',
                command = vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python',
                args = { '-m', 'debugpy.adapter' },
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
                    -- pythonPath = venv_python_path,
                    pythonPath = "${workspaceFolder}/.venv/bin/python",
                    program = "${workspaceFolder}/manage.py",
                    args = {
                        "test",
                        "${relativeFileDirname}"
                    },
                    django = true,
                    console = "integratedTerminal",
                },
            }
        end,
    })

    if install_plugins then
        packer.sync()
    end
end)

vim.cmd([[
command! DapUIToggle lua require("dapui").toggle()
]])

-- Use solarized8_flat color scheme when first time start
-- vim.cmd([[ colorscheme solarized8_flat ]])
-- vim.cmd([[ colorscheme gruvbox ]])
--------------------------------------------------------------------------------------


_G.load_config = function()
    vim.lsp.set_log_level("trace")
    if vim.fn.has("nvim-0.5.1") == 1 then
        require("vim.lsp.log").set_format_func(vim.inspect)
    end
    local nvim_lsp = require("lspconfig")
    local on_attach = function(_, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local opts = { noremap = true, silent = true }
        buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
        buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
        buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
        buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    end

    -- Add the server that troubles you here
    local name = "pyright"
    local cmd = { "pyright-langserver", "--stdio" } -- needed for elixirls, omnisharp, sumneko_lua
    if not name then
        print("You have not defined a server name, please edit minimal_init.lua")
    end
    if not nvim_lsp[name].document_config.default_config.cmd and not cmd then
        print([[You have not defined a server default cmd for a server
        that requires it please edit minimal_init.lua]])
    end

    nvim_lsp[name].setup({ cmd = cmd, on_attach = on_attach })

    print(
    [[You can find your log at $HOME/.cache/nvim/lsp.log. Please paste in a github issue under a details tag as described in the issue template.]]
    )
end
