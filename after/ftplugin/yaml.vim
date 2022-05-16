" set ts=2
" set sw=2
autocmd FileType yaml setlocal softtabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml execute  ':silent! %s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

set list
set listchars=tab:▷▷,trail:.
" Highlight tabs as errors.
" https://vi.stackexchange.com/a/9353/3168
match Error /\t/

