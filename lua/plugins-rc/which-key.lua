--------------------------------------------------------------------------
-- WhichKey Configuration
--------------------------------------------------------------------------
local which_key = safe_require('which-key')
if not which_key then
    return
end

local mappings = {
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
    -- Top Menu
    [' '] = { ':Telescope find_files<CR>', 'Find files' },
    [','] = { ':Telescope buffers<CR>', 'Show buffers' },
    [';'] = { ':FloatermNew --wintype=normal --height=10<CR>', 'Open Terminal' },
    ['v'] = { ':FloatermNew --height=0.7 --width=0.9 --wintype=float  vifm<CR>', 'ViFm' },
    ['/'] = { 'gcc', 'Comment out (Toggle)' },
    ['\\'] = { ':NvimTreeToggle<CR>', 'File explorer' },
    ['r'] = { ':Telescope yabs tasks<CR>', 'List tasks of YABS' },
    ['z'] = { 'UndotreeToggle<CR>', 'Undo tree' },
    -- Actions
    a = {
        name = 'actions',
        h = { ':let @/ = ""<CR>', 'remove search highlight' },
        t = { ':set filetype=htmldjango<CR>', 'set file type to django template' },
        T = { ':set filetype=html<CR>', 'set file type to HTML' },
        l = { ':set wrap!<CR>', 'on/off line wrap' },
        n = { ':set nonumber!<CR>', 'on/off line-numbers' },
        N = { ':set norelativenumber!<CR>', 'on/off relative line-numbers' },
    },
    -- Buffer
    b = {
        name = 'buffer',
        c = { ':bdelete<CR>', 'Close buffer' },
        C = { '%bdelete|edit #|normal `"<CR>', 'Close all but current' },
        I = { 'gg=G', 'Formate indent of line' },
        l = { ':Telescope buffers<CR>', 'List all buffers' },
        s = { ':setlocal spell!<CR>', 'Toggle spell' },
        w = { ':StripWhitespace<CR>', 'Strip white space' },
        W = { ':ToggleWhitespace<CR>', 'Toggle white space' },
        ['['] = { 'gT', 'Prev. buffer' },
        [']'] = { 'gt', 'Next buffer' },
    },
    -- Code Runner
    c = {
        name = 'Code Runner',
        r = {':TermExec cmd="python %"<CR>', 'Run python file'},
        d = {':TermExec cmd="python -m pdb %"<CR>', 'Debug python file'},
        m = {':TermExec cmd="nodemon -e py %"<CR>', 'Monitor python file'},
        p = {
            name = 'Python',
            r = { ':update<CR>:exec "!python3" shellescape(@%,1)<CR>', 'Run Python file' },
            d = { ':update<CR>:sp term://python3 -m pdb %<CR>', 'Debug Python file' },
            n = { ':update<CR>:sp term://nodemon -e py %<CR>', 'Monitor the file' },
        },
    },
    -- Debug
    d = {
        name = 'debug',
        b = { ":lua require'dap'.toggle_breakpoint()<CR>", 'Toggle breakpoint' },
        B = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", 'Condition breakpoint' },
        c = { ":lua require'dap'.continue()<CR>", 'Start debug...' },
        C = { ":lua require'dap-python'.test_method()<CR>", 'Debug to cursor' },
        o = { ":lua require'dap'.step_over()<CR>", 'Step over' },
        i = { ":lua require'dap'.step_into()<CR>", 'Step into' },
        O = { ":lua require'dap'.step_out()<CR>", 'Step out' },
        u = { ":lua require'dapui'.toggle()<CR>", 'Show/Hide Debug Sidebar' },
        v = { ":lua require'dap.ui.widgets'.hover()<CR>", 'Show contents in variable' },
        V = {
            "<cmd>lua local widgets=require'dap.ui.widgets'; widgets.centered_float(widgets.scopes)<CR>",
            'Use widgets to display the variables',
        },
    },
    -- Git
    g = {
        name = 'git',
        g = { ':Neogit<CR>', 'Neogit' },
        a = { ':Git add .<CR>', 'add all' },
        b = { ':Git blame<CR>', 'blame' },
        B = { ':GBrowse<CR>', 'Browse GitHub repo' },
        c = { ':Git commit<CR>', 'commit' },
        d = {
            name = '+Diff',
            h = { ':Gdiffsplit<CR>', 'diff split' },
            v = { ':Gvdiffsplit<CR>', 'diff vsplit' },
            n = { ':Git diff<CR>', 'Normal diff' },
        },
        l = { ':Git log<CR>', 'List log with details' },
        L = { ':Git log --oneline<CR>', 'List log within one line' },
        p = { ':Git push<CR>', 'push' },
        P = { ':Git pull<CR>', 'pull' },
        r = { ':GRemove<CR>', 'remove' },
        s = { ':Git<CR>', 'status' },
        S = { ':GitGutterSignsToggle<CR>', 'toggle signs' },
        T = { ':Git log --no-walk --tags --pretty="%h %d %s" --decorate=full<CR>', 'List all tags in log' },
        z = { ':FloatermNew lazygit<CR>', 'Lazygit' },
        -- Gist
        G = {
            name = 'gist',
            -- a    = {':Gist -a', 'post a gist anonymously' },
            -- b    = {':Gist -b', 'post gist browser' },
            d = { ':Gist -d<CR>', 'delete gist' },
            e = { ':Gist -e<CR>', 'edit gist' },
            l = { ':Gist -l<CR>', 'list public gists' },
            s = { ':Gist -ls<CR>', 'list starred gists' },
            m = { ':Gist -m<CR>', 'post a gist with all open buffers' },
            p = { ':Gist -p<CR>', 'post public gist' },
            P = { ':Gist -P<CR>', 'post private gist' },
	    },
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
    -- Window
    w = {
        name = 'window',
        ['-'] = { ':split<CR>', 'Horiz. window' },
        ['|'] = { ':vsplit<CR>', 'Vert. window' },
        z = { '<C-W>_', 'Zoom-in' },
        Z = { '<C-W>|', 'Zoom-in (Vertical)' },
        o = { '<C-W>=', 'Zoom-out' },
        c = { ':close<CR>', 'Close window' },
        k = { '<C-w>k', 'Up window' },
        j = { '<C-w>j', 'Down window' },
        h = { '<C-w>h', 'Left window' },
        l = { '<C-w>l', 'Right window' },
        ['<Up>'] = { '<cmd>wincmd -<CR>', 'Shrink down' },
        ['<Down>'] = { '<cmd>wincmd +<CR>', 'Grow up' },
        ['<Left>'] = { '<cmd>wincmd <<CR>', 'Shrink narrowed' },
        ['<Right>'] = { '<cmd>wincmd ><CR>', 'Grow widder' },
        w = { ':exe "resize" . (winwidth(0) * 3/2)<CR>', 'Increase weight' },
        W = { ':exe "resize" . (winwidth(0) * 2/3)<CR>', 'Increase weight' },
        v = { ':exe "vertical resize" . (winheight(0) * 3/2)<CR>', 'Increase height' },
        V = { ':exe "vertical resize" . (winheight(0) * 2/3)<CR>', 'Increase height' },
    },
}

local opts = {
    prefix = '<leader>',
}

which_key.register(mappings, opts)

