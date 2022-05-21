"=================================================================
"(1)  We check if a compiler is configured for the current 
"	  file (:h current_compiler). If not we will set it to python.
"
"(2)  We add python to the list of compiler options.
"
"(3)  We configure makeprg (:h makeprg) which is the command 
"	  to build or run the file. It is used by the :make command.
"
"(4)  We configure the error format (:h errorformat) for Python.
"
" With the compiler configured, we should be able to see Python
" in the compiler list when we type :compiler.
"=================================================================
if exists("current_compiler")
  finish
endif

let current_compiler = "python"
if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=python\ %

CompilerSet errorformat=
	\%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
	\%C\ \ \ \ %.%#,
	\%+Z%.%#Error\:\ %.%#,
	\%A\ \ File\ \"%f\"\\\,\ line\ %l,
	\%+C\ \ %.%#,
	\%-C%p^,
	\%Z%m,
	\%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
