" vim-better-whitespace.rc.vim
" Plugin configuraiton: vim-better-whitespace
" =============================================================================
"
" To enable/disable/toggle whitespace highlighting in a buffer, call one of:
" :EnableWhitespace
" :DisableWhitespace
" :ToggleWhitespace
"
" To enable/disable stripping of extra whitespace on file save for a buffer, call one of:
" :EnableStripWhitespaceOnSave
" :DisableStripWhitespaceOnSave
" :ToggleStripWhitespaceOnSave
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

autocmd FileType dashboard DisableWhitespace

" Disable white spacing highlights.
let g:better_whitespace_filetypes_blacklist = [ 'diff', 'gitcommit', 'qf', 'help', 'markdown', 'dashboard', 'packer' ]

" Don't ask for confirmation before whitespace is stripped when you save the file.
let g:strip_whitespace_confirm = 0
let g:show_spaces_that_precede_tabs = 1
