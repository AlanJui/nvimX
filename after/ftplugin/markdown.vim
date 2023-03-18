set textwidth=120
set wrap
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

augroup markdown_settings
  autocmd!
  autocmd FileType markdown setlocal expandtab
  autocmd FileType markdown setlocal tabstop=2
  autocmd FileType markdown setlocal shiftwidth=2
augroup END
