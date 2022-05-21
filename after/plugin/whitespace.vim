function! s:trim_trailing_whitespace() abort
  let l:view = winsaveview()
  keeppatterns %substitute/\m\s\+$//e
  call winrestview(l:view)
endfunction

augroup trim_spaces
  autocmd!
  autocmd BufWritePre * call <SID>trim_trailing_whitespace()
augroup END
