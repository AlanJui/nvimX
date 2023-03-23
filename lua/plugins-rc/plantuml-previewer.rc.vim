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
" PlantUML was installed by homebrew
" autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
"
"     \  matchlist(system('cat `which plantuml` | grep plantuml.jar'), '\v.*\s[''"]?(\S+plantuml\.jar).*'),
"     \  1,
"     \  0
"     \)


lua << EOF

local plantuml_jar_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/plantuml-previewer.vim/lib/plantuml.jar'
vim.g.puml_jar_path = plantuml_jar_path
vim.g.puml_previewer = vim.fn.stdpath('data') .. '/site/pack/packer/start/plantuml-previewer.vim/viewer/dist'

EOF

" The plugin will copy viewer to here if the directory does not exist.
" And tmp.puml and tmp.svg will output to here.
" Defualt Home Page Path: ~/.vim/plugged/plantuml-previewer.vim/viewer/dist/index.html
" let g:plantuml_previewer#viewer_path = puml_previewer
autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = g:puml_jar_path
" autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = "/Users/alanjui/.local/share/nvim/site/pack/packer/start/plantuml-previewer.vim/lib/plantuml.jar"

" function! SavePlantUmlInCurrentDir()
"     let l:current_dir = expand('%:p:h')
"     let g:plantuml_previewer#save_dir = l:current_dir
"     exe 'PlantumlSave'
" endfunction
"
" command! PlantumlSaveCurrentDir call SavePlantUmlInCurrentDir()

" PlantumlSave default formate
let g:plantuml_previewer#save_format = 'png'

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let  g:mkdp_auto_start  =  0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let  g:mkdp_auto_close  =  1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let  g:mkdp_refresh_slow  =  0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let  g:mkdp_command_for_global  =  0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let  g:mkdp_open_to_the_world  =  0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let  g:mkdp_open_ip  =  ''

" specify browser to open preview page
" default: ''
let  g:mkdp_browser  =  ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let  g:mkdp_echo_preview_url  =  0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let  g:mkdp_browserfunc  =  ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
" middle: mean the cursor position alway show at the middle of the preview page
" top: mean the vim top viewport alway show at the top of the preview page
" relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams:js-sequence-diagrams options
let  g:mkdp_preview_options =  {
    \  'mkit' :  {},
    \  'katex' :  {},
    \  'uml' :  {},
    \  'maid' :  {},
    \  'disable_sync_scroll' :  0 ,
    \  'sync_scroll_type' :  'middle' ,
    \  'hide_yaml_meta' :  1 ,
    \  'sequence_diagrams' :  {},
    \  'flowchart_diagrams' :  {}
    \  }

" use a custom markdown style must be absolute path
let  g:mkdp_markdown_css  =  ''

" use a custom highlight style must absolute path
let  g:mkdp_highlight_css  =  ''

" use a custom port to start server or random for empty
let  g:mkdp_port  =  ''

" preview page title
" ${name} will be replace with the file name
let  g:mkdp_page_title  =  '「${name}」'
