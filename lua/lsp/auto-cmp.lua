local ok, cmp = pcall(require, 'cmp')
if not ok then
    return
end

local LuaSnip = require('luasnip')
if not LuaSnip then
    return
end

------------------------------------------------------------
-- Add Snippets
------------------------------------------------------------

-- Load your own custom vscode style snippets
require("luasnip.loaders.from_vscode").lazy_load({
	paths = {
		CONFIG_DIR .. "/my-snippets",
		RUNTIME_DIR .. "/site/pack/packer/start/friendly-snippets",
	},
})

require("luasnip").filetype_extend("vimwik", { "markdown" })
require("luasnip").filetype_extend("html", { "htmldjango" })

-- Require function for tab to work with LUA-SNIP
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    cmpletion = {
        -- completeopt = "menu, menuone, noinsert",
        completeopt = "menu, menuone, noselect",
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            LuaSnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-m>'] = cmp.mapping.complete(),
        ['<M-m>'] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif LuaSnip.expand_or_jumpable() then
                LuaSnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif LuaSnip.jumpable(-1) then
                LuaSnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        -- Jump to the next placeholder in the snippet
        ['<C-d>'] = cmp.mapping(function(fallback)
            if LuaSnip.jumpable(1) then
                LuaSnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),
        -- Jump to the previous placeholder in the snippet
        ['<C-b>'] = cmp.mapping(function(fallback)
            if LuaSnip.jumpable(-1) then
                LuaSnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
        -- Shows available snippets and expands them if they are chosen
        { name = "luasnip", keyword_length = 2 },
        -- Shows suggestions based on the response of a language server
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "nvim_lua" },
        -- Autocomplete file paths
        { name = "path" },
        { name = "emoji" },
        { name = "spell" },
        -- Suggests words found in the current buffer
        { name = "buffer", keyword_length = 3 },
    },
    -- sources = cmp.config.sources({
    --     { name = "luasnip" },
    --     { name = "nvim_lsp" },
    --     { name = "nvim_lua" },
    --     { name = "path" },
    --     { name = "emoji" },
    --     { name = "spell" },
    -- }, {
    --     { name = 'buffer' },
    -- }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- set a name for each source
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                buffer = "[Buff]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
                spell = "[Spell]",
                treesitter = "[TreeSitter]",
                zsh = "[Zsh]",
                path = "[Path]",
            })[entry.source.name]

            return vim_item
        end,
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

