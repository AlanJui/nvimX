" The architecture looks something like this:
" +-----+--------+    +--------+     +---------+
" | vim | python |    | nodejs |     | browser |
" |     | plugin ---->| server |---->| client  |
" |     |        |    |        |     |         |
" +-----+--------+    +--------+     +---------+
"
" g:bracey_browser_command
" default: 0

" (string) command used to launch browser
" 0 if it should be detected automatically using xdg-open
" g:bracey_auto_start_browser
" default: 1

" (false: 0, true: 1) whether or not to start the browser (by running g:bracey_browser_command) when bracey is started
" g:bracey_refresh_on_save
" default: 0

" (false: 0, true: 1) whether or not to reload the current web page whenever its corresponding buffer is written
" g:bracey_eval_on_save
" default: 1

" (false: 0, true: 1) whether or not to evaluate a buffer containing javascript when it is saved
" g:bracey_auto_start_server
" default: 1

" (false: 0, true: 1) whether or not to start the node server when :Bracey is run
" g:bracey_server_allow_remote_connections
" default: 0

" (false: 0, true: 1) whether or not to allow other machines on the network to connect to the node server's webpage. This is useful if you want to view what changes will look like on other platforms at the same time
" g:bracey_server_port
" default: random-ish number derived from vim's pid

" (int) the port that the node server will serve files at and receive commands at
" g:bracey_server_path
" default: 'http://127.0.0.1'

" (string) address at which the node server will reside at (should start with 'http://' and not include port)
" g:bracey_server_log
" default: '/tmp/bracey_server_logfile'

" (string) location to log the node servers output
