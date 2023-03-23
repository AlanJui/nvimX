" " Try to load the plugin
" silent! call YourPluginFunction()
"
" " If loading the plugin fails, skip the rest of the script
" if v:exception != ""
"   finish
" endif
"
" " Continue with the rest of the script
" call YourOtherPluginFunction()

" 尝试加载 hardtime 插件
silent! call hardtime#setup()

" 如果加载插件失败，则跳过脚本的剩余部分
if v:exception != ""
	echo "hardtime plugin not found"
	finish
endif

" 设置 g:hardtime_column 变量
let g:hardtime_column = 80

" 在此处继续其他脚本内容
