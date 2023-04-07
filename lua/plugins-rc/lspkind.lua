local status, lspkind = pcall(require, "lspkind")
if not status then
    return
end

local M = {}

function M.init()
    lspkind.init({
        -- DEPRECATED (use mode instead): enables text annotations
        --
        -- default: true
        -- with_text = true,

        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = "symbol_text",

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        -- preset = "codicons",
        preset = "default",

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
            Copilot = "",
            Text = "  ",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "ﰠ",
            Variable = "",
            Class = "ﴯ",
            Interface = "  ",
            Module = "",
            Property = "  ",
            Unit = "  ",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "  ",
            File = "  ",
            Reference = "  ",
            Folder = "  ",
            EnumMember = "",
            Constant = "",
            Struct = "פּ",
            Event = "  ",
            Operator = "  ",
            TypeParameter = "  ",
        },
    })
end

return M
