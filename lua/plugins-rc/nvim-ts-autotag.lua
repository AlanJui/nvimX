-- nvim-ts-autotag.lua
local nvim_ts_autotag = safe_require('nvim-ts-autotag')
if not nvim_ts_autotag then
    return
end

local filetypes = {
    'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
    'xml',
    'markdown',
    'glimmer','handlebars','hbs'
}

local skip_tags = {
  'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
  'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr','menuitem'
}

nvim_ts_autotag.setup({
    filetypes = filetypes,
    skip_tags = skip_tags,
})
