" echo "Vimtex plugin has been installed!"


"{ Global Variable
"{{ Custom variables
let g:is_win = (has('win32') || has('win64')) ? v:true : v:false
let g:is_linux = (has('unix') && !has('macunix')) ? v:true : v:false
let g:is_mac = has('macunix') ? v:true : v:false
let g:logging_level = 'info'
"}}

if ( g:is_win || g:is_mac ) && executable('latex')
    " Hacks for inverse serach to work semi-automatically,
    " see https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/.
    function! s:write_server_name() abort
        let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
        call writefile([v:servername], nvim_server_file)
    endfunction

    augroup vimtex_common
        autocmd!
        autocmd FileType tex call s:write_server_name()
        autocmd FileType tex nmap <buffer> <F2> <plug>(vimtex-compile)
    augroup END

    let g:vimtex_compiler_latexmk = {
                \ 'build_dir' : 'build',
                \ }

    " TOC settings
    let g:vimtex_toc_config = {
                \ 'name' : 'TOC',
                \ 'layers' : ['content', 'todo', 'include'],
                \ 'resize' : 1,
                \ 'split_width' : 30,
                \ 'todo_sorted' : 0,
                \ 'show_help' : 1,
                \ 'show_numbers' : 1,
                \ 'mode' : 2,
                \ }

    " Viewer settings for different platforms
    if g:is_win
        let g:vimtex_view_general_viewer = 'SumatraPDF'
        let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    endif

    if g:is_mac
        " let g:vimtex_view_method = "skim"
        let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'

        augroup vimtex_mac
            autocmd!
            autocmd User VimtexEventCompileSuccess call UpdateSkim()
        augroup END

        " The following code is adapted from https://gist.github.com/skulumani/7ea00478c63193a832a6d3f2e661a536.
        function! UpdateSkim() abort
            let l:out = b:vimtex.out()
            let l:src_file_path = expand('%:p')
            let l:cmd = [g:vimtex_view_general_viewer, '-r']

            if !empty(system('pgrep Skim'))
                call extend(l:cmd, ['-g'])
            endif

            call jobstart(l:cmd + [line('.'), l:out, l:src_file_path])
        endfunction
    endif
endif

"echo "vimtex.vim is loaded! "
