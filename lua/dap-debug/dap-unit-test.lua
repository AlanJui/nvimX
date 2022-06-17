-----------------------------------------------------------
-- vim-ultest: Unit Test Tool
-- :help ultest-debugging
-----------------------------------------------------------

-- To tell test runner tolways output with colour.
vim.cmd([[
let test#python#pytest#options = "--color=yes"
let test#javascript#jest#options = "--color=always"
]])

-- For user of Neovim >= 0.5, you can enable PTY usage which
-- makes the process think it is in an interactive session
vim.cmd([[
let g:ultest_use_pty = 1
]])

-- To run the nearest test every time a file is written:
vim.cmd([[
augroup UltestRunner
    au!
    au BufWritePost * UltestNearest
augroup END
]])

-- To be able to jump between failures in a test files
vim.cmd([[
nmap ]t <Plug>(ultest-next-fail)
nmap [t <Plug>(ultest-prev-fail)
]])
