return {
    filetypes = { 'json', 'jsonc' },
    settings = {
        json = {
            schemas = require('lsp/json-schemas'),
        },
    },
    setup = {
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
                end,
            },
        },
    },
    init_options = {
        provideFormatter = true,
    },
    single_file_support = true,
}
