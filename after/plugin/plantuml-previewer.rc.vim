" plantuml-previewer-vim.rc.vim

" https://github.com/weirongxu/plantuml-previewer.vim
" Vim/Neovim plugin for preview PlantUML
"
" Dependencies:
"  - Java
"  - Graphviz (https://www.graphviz.org/download/)
"     * brew install graphviz
"     * apt install graphviz
"  - open-browser.vim
"  - aklt/plantuml-syntax (vim syntax file for plantuml)
"
" Usage:
"  1. Start editing plantuml  file in Vim.
"  2. Run :PlantumlOpen to open previewer webpage in browser.
"  3. Saving plantuml file in Vim, then previewer webpage will refresh
"
" Commands:
"
"  - PlantumlOpen: Open previewer webpage in browser, and watch current buffer
"
"  - PlantumlStop: Stop watch buffer
"
"  - PlantumlSave [filepath] [format]: Export UML diagram to file path
"
"    [Available Formats]:
"    png, svg, eps, pdf, vdx, xmi, scxml, html, txt, utxt, latex
"
" Configuration:
"

"autocmd FileType plantuml nnoremap <buffer> <Leader>b :!java -jar ~/.vim/autoload/plantuml.jar -tpng -o %:p:h %<cr>
" autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = '~/.vim/autoload/plantuml.jar'

autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = '/Users/alanjui/bin/plantuml.jar'

" PlantumlSave default formate
let g:plantuml_previewer#save_format = 'png'

" The plugin will copy viewer to here if the directory does not exist.
" And tmp.puml and tmp.svg will output to here.
" Defualt Home Page Path: ~/.vim/plugged/plantuml-previewer.vim/viewer/dist/index.html

"let g:plantuml_previewer#viewer_path = '~/.vim/plugged/plantuml-previewer.vim/viewer/dist'
"let g:plantuml_previewer#viewer_path = '/Users/alanjui/bin/plantuml-previewer.vim/viewer/dist'

