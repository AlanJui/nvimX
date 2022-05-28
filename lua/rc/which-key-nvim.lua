--------------------------------------------------------------------------
-- WhichKey Configuration
--------------------------------------------------------------------------
local which_key = safe_require('which-key')
if not which_key then
    return
end
-- print('Plugin: which-key is installed')

local mappings = {
    -- Top Menu
    [' '] = { ':Telescope find_files<CR>', 'Find files' },
    [','] = { ':Telescope buffers<CR>', 'Show buffers' },
    [';'] = { ':FloatermNew --wintype=normal --height=10<CR>', 'Open Terminal' },
    ['v'] = { ':FloatermNew --height=0.7 --width=0.9 --wintype=float  vifm<CR>', 'ViFm' },
    -- Languages Server Protocol
    l = {
        name = 'LSP',
        a = { ':call v:lua.vim.lsp.buf.code_action()<CR>', 'Do CodeAction' },
        A = { ':call v:lua.vim.lsp.buf.range_code_action()<CR>', 'Do Range CodeAction' },
        f = { ':call v:lua.vim.lsp.buf.formatting()<CR>', 'Formatting code' },
        k = { ':call v:lua.vim.lsp.buf.hover()<CR>', 'Show HoverDocument' },
        r = { ':call v:lua.vim.lsp.buf.rename()<CR>', 'Rename buffer' },
        s = { ':call v:lua.vim.lsp.buf.signature_help()<CR>', 'Show signature help' },
        d = {
            name = 'diagnostics',
            s = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', 'Set loclist' },
            l = { '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', 'Show line diagnostics' },
            D = { ':Telescope diagnostics<CR>', 'List diagnostics in worksapce' },
            d = { ':Telescope diagnostics bufnr=0<CR>', 'List diagnostics current file' },
            e = { ':call v:lua.vim.diagnostic.open_float()<CR>', 'Open diagnostics floating' },
            p = { ':call v:lua.vim.diagnostic.goto_prev()<CR>', 'Goto prev diagnostics' },
            n = { ':call v:lua.vim.diagnostic.goto_next()<CR>', 'Goto next diagnostics' },
        },
        g = {
            name = 'goto',
            D = { ':call v:lua.vim.lsp.buf.declaration()<CR>', 'Go to declaration' },
            d = { ':call v:lua.vim.lsp.buf.definition()<CR>', 'Go to definition' },
            t = { ':call v:lua.vim.lsp.buf.type_definition()<CR>', 'Go to type definition' },
            i = { ':call v:lua.vim.lsp.buf.implementation()<CR>', 'Go to Implementation' },
            r = { ':call v:lua.vim.lsp.buf.references()<CR>', 'References' },
        },
        t = {
            name = 'Filetypes',
            t = { ':set filetype=htmldjango<CR>', 'set file type to django template' },
            T = { ':set filetype=html<CR>', 'set file type to HTML' },
        },
        w = {
            name = 'workspace',
            l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List workspace folders' },
            a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add folder to workspace' },
            r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove folder from workspace' },
        },
    },
    -- Code Runner
    y = { ':Telescope yabs tasks<CR>', 'List tasks of YABS' },
    r = {
        name = 'Code Runner',
        -- name = 'TermExec',
        r = {':TermExec cmd="python %"<CR>', 'Run python file'},
        d = {':TermExec cmd="python -m pdb %"<CR>', 'Debug python file'},
        m = {':TermExec cmd="nodemon -e py %"<CR>', 'Monitor python file'},
        p = {
            name = 'Python',
            r = { ':update<CR>:exec "!python3" shellescape(@%,1)<CR>', 'Run Python file' },
            d = { ':update<CR>:sp term://python3 -m pdb %<CR>', 'Debug Python file' },
            n = { ':update<CR>:sp term://nodemon -e py %<CR>', 'Monitor the file' },
            t = {
            },
        }
    },
    -- git
    g = {
        name = 'Git',
        g = { ':Neogit<CR>', 'Neogit' },
        j = { '<plug>(signify-next-hunk)', 'Jump to next changed' },
        k = { '<plug>(signify-prev-hunk)', 'Jump to prev changed' },
        b = { ':GV<CR>', 'Browse git commit records' },
        d = {
            name = 'diff',
            d = { ':Gdiffsplit<CR>',  'Show gitdiff' },
            h = { ':Ghdiffsplit<CR>', 'Show gitdiff with Up/Down panel' },
            v = { ':Gvdiffsplit<CR>', 'Show gitdiff with Left/Right panel' },
        },
    },
    -- Configure Neovim
    n = {
        name = 'Neovim',
        i = { ':e ~/.config/nvim/init.lua<CR>', 'nvim/init.lua' },
        a = { ':e ~/.config/nvim/lua/add-on-plugins.lua<CR>', 'configure packer.nvim' },
        p = { ':e ~/.config/nvim/lua/plugins.lua<CR>', 'specifying plugins' },
        k = { ':e ~/.config/nvim/lua/keybindings.lua<CR>', 'keybindings' },
        w = { ':e ~/.config/nvim/lua/rc/which-key-nvim.lua<CR>', 'which-key' },
        s = { ':source ~/.config/nvim/init.lua<CR>', 'reload' },
        S = { ':PackerSync<CR>', 'PackerSync' },
        C = { ':PackerCompile<CR>', 'PackerCompile' },
        c = {
            name = 'configuration',
            d = { ':e ~/.config/nvim/lua/rc<CR>', 'list files in rc dir' },
            r = { ':e ~/.config/nvim/lua/rc/plugin.lua', 'create rc for plugin' },
        },
        e = {
            name = 'environment',
            i = { ':e ~/.config/nvim/lua/init-env.lua<CR>', 'init environment' },
            g = { ':e ~/.config/nvim/lua/globals.lua<CR>', 'globals functions' },
            e = { ':e ~/.config/nvim/lua/essential.lua<CR>', 'essential for neovim' },
            o = { ':e ~/.config/nvim/lua/options.lua<CR>', 'plugins\'soptions' },
            s = { ':e ~/.config/nvim/lua/settings.lua<CR>', 'user\'s settings' },
            u = { ':e ~/.config/nvim/lua/utils.lua<CR>', 'utils' },
            n = { ':e ~/.config/nvim/lua/nvim_utils.lua<CR>', 'nvim_utils' },
            c = { ':e ~/.config/nvim/lua/color-themes.lua<CR>', 'colorscheme' },
        },
        l = {
            name = 'lsp',
            d = { ':e ~/.config/nvim/lua/lsp<CR>', 'list files in dir' },
            i = { ':e ~/.config/nvim/lua/lsp/init.lua<CR>', 'configure lsp main' },
            c = { ':e ~/.config/nvim/lua/lsp/auto-cmp.lua<CR>', 'configure auto-completion' },
            s = { ':e ~/.config/nvim/lua/lsp/luasnip.lua<CR>', 'configure snippets' },
            S = { ':e ~/.config/nvim/lua/lsp/server-settings.lua<CR>', 'configure server setting' },
        },
    },
    -- Actions
    a = {
        name = 'actions',
        r = { ':let @/ = ""<CR>', 'remove search highlight' },
        l = { ':set wrap!<CR>', 'on/off line wrap' },
        n = { ':set nonumber!<CR>', 'on/off line-numbers' },
        N = { ':set norelativenumber!<CR>', 'on/off relative line-numbers' },
        h = { ':set filetype=htmldjango<CR>', 'set file type to django template' },
        H = { ':set filetype=html<CR>', 'set file type to HTML' },
        f = { ':set foldmethod=indent<CR>', 'Set code folding by indent' },
    },
    -- utilities
    u = {
        name = 'utilities',
        t = {
            name = 'terminal',
            d = { ':FloatermNew python manage.py shell<CR>', 'Django-admin Shell' },
            p = { ':FloatermNew python<CR>', 'Python shell' },
            n = { ':FloatermNew node<CR>', 'Node.js shell' },
            v = { ":FloatermNew --wintype='vsplit' --position='right'<CR>", 'Debug Term...' },
        },
        l = {
            name = 'LiveServer',
            l = { ':Bracey<CR>', 'start live server' },
            L = { ':BraceyStop<CR>', 'stop live server' },
            r = { ':BraceyReload<CR>', 'web page to be reloaded' },
        },
        m = {
            name = 'Markdown',
            m = { ':MarkdownPreview<CR>', 'start markdown preview' },
            M = { ':MarkdownPreviewStop<CR>', 'stop markdown preview' },
        },
        u = {
            name = 'UML',
            v = { ':PlantumlOpen<CR>', 'start PlantUML preview' },
            o = { ':PlantumlSave docs/diagrams/out.png<CR>', 'export PlantUML diagram' },
        },
        f = { ':FloatermNew --height=0.7 --width=0.9 --wintype=float vifm<CR>', 'ViFm' },
        r = { ':FloatermNew --height=0.7 --width=0.9 --wintype=float ranger<CR>', 'Ranger' },
    },
}

local opts = {
    prefix = '<leader>',
}

which_key.register(mappings, opts)

