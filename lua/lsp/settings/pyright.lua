local M = {}

function M.setup(on_attach, capabilities)
    return {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "off",
                    logLevel = "Error",
                },
                -- linting = {
                -- 	pylintArgs = {
                -- 		"--load-plugins=pylint_django",
                -- 		"--load-plugins=pylint_dango.checkers.migrations",
                -- 		"--errors-only",
                -- 	},
                -- },
            },
        },
        single_file_support = true,
    }
end

return M
