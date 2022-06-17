-----------------------------------------------------------
-- Neovim options
-----------------------------------------------------------
-- Configurations of Neovim
vim.cmd [[
let g:tex_flavor = "latex"
]]

-- Folding Text
-- vim.cmd [[
-- autocmd BufWinLeave *.* mkview
-- autocmd BufWinEnter *.* silent loadview
-- ]]

-- Django
vim.cmd [[
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>

augroup filetypedetect
  " removes current htmldjango detection located at $VIMRUNTIME/filetype.vim
  autocmd! BufNewFile,BufRead *.html
  autocmd  BufNewFile,BufRead *.html call FThtml()

  func! FThtml()
    let n = 1
    while n < 10 && n < line("$")
        if getline(n) =~ '{%\|{{\|{#'
        setf htmldjango
        return
      endif
      let n = n + 1
    endwhile
    "setf html
    setf html
  endfunc
augroup END
]]
