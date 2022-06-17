
return {
    filetypes = { 'python' },
    settings = {
        python = {
            analysis = {
                diagnosticMode = 'workspace',
                typeCheckingMode = 'off',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                logLevel = 'Error',
            },
            linting = {
                pylintArgs = {
                    '--load-plugins=pylint_django',
                    '--load-plugins=pylint_dango.checkers.migrations',
                    '--errors-only',
                },
            },
        },
    },
    single_file_support = true,
}
