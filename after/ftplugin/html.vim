" Tabs
set ts=4
set sw=4

let b:surround_{char2nr("v")} = "{{ \r }}"
let b:surround_{char2nr("{")} = "{{ \r }}"
let b:surround_{char2nr("%")} = "{% \r %}"
let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"

"--------------------------------------------------------------
" Django
"
" autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
" autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
" autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
" autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>
"
" 判別是否適用 htmldjango 檔案格式
" === To enable filetype for htmldjango ===
" 判別是否適用 django-html 檔案格式
" 可能選項：
"  (1) {% extends
"  (2) {% block
"  (3) {% load
"  (4) {#
" Regex Express 判別式：
"  (1) {%\s*\(extends\|block\|load\)\>\|{#\s\+
"  (2) {%\|{{\|{#
"
" augroup filetypedetect
"   " removes current htmldjango detection located at $VIMRUNTIME/filetype.vim
"   autocmd! BufNewFile,BufRead *.html
"   autocmd  BufNewFile,BufRead *.html call FThtml()
"
"   func! FThtml()
"     let n = 1
"     while n < 10 && n < line("$")
"         if getline(n) =~ '{%\|{{\|{#'
"         setf htmldjango
"         return
"       endif
"       let n = n + 1
"     endwhile
"     "setf html
"     setf html
"   endfunc
" augroup END
