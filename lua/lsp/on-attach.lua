-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-----------------------------------------------------------------------------------------------
local util = require('vim.lsp.util')

local formatting_callback = function(client, bufnr)
	vim.keymap.set('n', '<leader>f', function()
		local params = util.make_formatting_params({})
		client.request('textDocument/formatting', params, nil, bufnr)
	end, { buffer = bufnr })
end

local function lsp_highlight_document(client)
   -- Set autocommands conditional on server_capabilities
    local illuminate = safe_require('illuminate')
    if not illuminate then
        return
    end
    illuminate.on_attach(client)
end

local function lsp_keymaps(bufnr)
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		'n',
		'<space>wl',
		'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Multiple language servers with the built-in client are supported, however, it is highly
	-- recommended to avoid this if possible. Each server attached to a buffer carries a small
	-- amount of performance overhead, and the response to each request is overwritten by the
	-- previous server's response.
	-- if client.name ~= 'sumneko_lua' then
	--   formatting_callback(client, bufnr)
	-- end

    if client.name == 'tsserver' or client.name == 'html'
        or client.name == 'diagnosticls' or client.name == 'sumneko_lua' then
        client.resolved_capabilities.document_formatting = false
    end

    -- Neovim 0.7: highlight symbol under cursor
    -- if client.name ~= 'texlab' and
    --    client.resolved_capabilities.document_highlight then
    --     vim.cmd [[
    --         hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
    --         hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
    --         hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
    --         augroup lsp_document_highlight
    --         autocmd! * <buffer>
    --         autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --         autocmd! CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
    --         autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --         augroup END
    --     ]]
    -- end

    -- Neovim v0.7: Show line diagnostics automatically in hover window
    vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
        local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end
    })

    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

return on_attach
