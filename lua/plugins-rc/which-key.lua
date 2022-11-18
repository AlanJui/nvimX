--------------------------------------------------------------------------
-- WhichKey Configuration
--------------------------------------------------------------------------
local which_key = safe_require("which-key")
if not which_key then
	return
end

local mappings = {
	-- Configure Neovim
	n = {
		name = "Neovim",
		i = { ":e ~/.config/nvim/init.lua<CR>", "nvim/init.lua" },
		a = {
			":e ~/.config/nvim/lua/add-on-plugins.lua<CR>",
			"configure packer.nvim",
		},
		p = { ":e ~/.config/nvim/lua/plugins.lua<CR>", "specifying plugins" },
		k = { ":e ~/.config/nvim/lua/keybindings.lua<CR>", "keybindings" },
		w = { ":e ~/.config/nvim/lua/rc/which-key-nvim.lua<CR>", "which-key" },
		s = { ":source ~/.config/nvim/init.lua<CR>", "reload" },
		S = { ":PackerSync<CR>", "PackerSync" },
		C = { ":PackerCompile<CR>", "PackerCompile" },
		c = {
			name = "configuration",
			d = { ":e ~/.config/nvim/lua/rc<CR>", "list files in rc dir" },
			r = { ":e ~/.config/nvim/lua/rc/plugin.lua", "create rc for plugin" },
		},
		e = {
			name = "environment",
			i = { ":e ~/.config/nvim/lua/init-env.lua<CR>", "init environment" },
			g = { ":e ~/.config/nvim/lua/globals.lua<CR>", "globals functions" },
			e = {
				":e ~/.config/nvim/lua/essential.lua<CR>",
				"essential for neovim",
			},
			o = { ":e ~/.config/nvim/lua/options.lua<CR>", "plugins'soptions" },
			s = { ":e ~/.config/nvim/lua/settings.lua<CR>", "user's settings" },
			u = { ":e ~/.config/nvim/lua/utils.lua<CR>", "utils" },
			n = { ":e ~/.config/nvim/lua/nvim_utils.lua<CR>", "nvim_utils" },
			c = { ":e ~/.config/nvim/lua/color-themes.lua<CR>", "colorscheme" },
		},
		l = {
			name = "lsp",
			d = { ":e ~/.config/nvim/lua/lsp<CR>", "list files in dir" },
			i = { ":e ~/.config/nvim/lua/lsp/init.lua<CR>", "configure lsp main" },
			c = {
				":e ~/.config/nvim/lua/lsp/auto-cmp.lua<CR>",
				"configure auto-completion",
			},
			s = {
				":e ~/.config/nvim/lua/lsp/luasnip.lua<CR>",
				"configure snippets",
			},
			S = {
				":e ~/.config/nvim/lua/lsp/server-settings.lua<CR>",
				"configure server setting",
			},
		},
	},
	-- Top Menu
	[" "] = { ":Telescope find_files<CR>", "Find files" },
	[","] = { ":Telescope buffers<CR>", "Show buffers" },
	[";"] = { ":FloatermNew --wintype=normal --height=10<CR>", "Open Terminal" },
	["v"] = {
		":FloatermNew --height=0.7 --width=0.9 --wintype=float  vifm<CR>",
		"ViFm",
	},
	["/"] = { "gcc", "Comment out (Toggle)" },
	["\\"] = { ":NvimTreeToggle<CR>", "File explorer" },
	["y"] = { ":Telescope yabs tasks<CR>", "List tasks of YABS" },
	["z"] = { "UndotreeToggle<CR>", "Undo tree" },
	-- Actions
	a = {
		name = "Actions",
		h = { ':let @/ = ""<CR>', "remove search highlight" },
		t = { ":set filetype=htmldjango<CR>", "set file type to django template" },
		T = { ":set filetype=html<CR>", "set file type to HTML" },
		l = { ":set wrap!<CR>", "on/off line wrap" },
		n = { ":set nonumber!<CR>", "on/off line-numbers" },
		N = { ":set norelativenumber!<CR>", "on/off relative line-numbers" },
	},
	-- Buffer
	b = {
		name = "Buffers",
		c = { ":bdelete<CR>", "Close buffer" },
		C = { '%bdelete|edit #|normal `"<CR>', "Close all but current" },
		I = { "gg=G", "Formate indent of line" },
		l = { ":Telescope buffers<CR>", "List all buffers" },
		s = { ":setlocal spell!<CR>", "Toggle spell" },
		w = { ":StripWhitespace<CR>", "Strip white space" },
		W = { ":ToggleWhitespace<CR>", "Toggle white space" },
		["["] = { "gT", "Prev. buffer" },
		["]"] = { "gt", "Next buffer" },
	},
	-- Coding
	c = {
		name = "Coding",
		a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Do CodeAction" },
		A = {
			"<cmd>lua vim.lsp.buf.range_code_action()<CR>",
			"Do Range CodeAction",
		},
		f = { "<cmd>lua vim.lsp.buf.format()<CR>", "LSP formatting code" },
		k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show HoverDocument" },
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename code" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
		g = {
			name = "goto",
			D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
			d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
			t = {
				"<cmd>lua vim.lsp.buf.type_definition()<CR>",
				"Go to type definition",
			},
			i = {
				"<cmd>lua vim.lsp.buf.implementation()<CR>",
				"Go to Implementation",
			},
			r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		},
		m = {
			name = "misc",
			t = {
				":set filetype=htmldjango<CR>",
				"set file type to django template",
			},
			T = { ":set filetype=html<CR>", "set file type to HTML" },
		},
		w = {
			name = "workspace",
			l = {
				"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
				"List workspace folders",
			},
			a = {
				"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
				"Add folder to workspace",
			},
			r = {
				"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
				"Remove folder from workspace",
			},
		},
	},
	-- Debug
	d = {
		name = "Debug",
		b = {
			"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
			"Toggle breakpoint",
		},
		B = {
			"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition<cmd> '))<CR>",
			"Condition breakpoint",
		},
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
		R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
		i = { "<cmd>lua require'dap'.step_into()<CR>", "Step into" },
		o = { "<cmd>lua require'dap'.step_over()<CR>", "Step over" },
		O = { "<cmd>lua require'dap'.step_out()<CR>", "Step out" },
		p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
		g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
		Q = {
			"<cmd>lua require'dap'.close()<CR><cmd>lua require'dap.repl'.close()<CR><cmd>lua require'dapui'.close()<CR><cmd>DapVirtualTextForceRefresh<CR>",
			"Quit Nvim DAP",
		},
		-- Show contents in Variable when mouse pointer hover
		h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
		e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
		S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
		u = { "<cmd>lua require'dapui'.toggle()<CR>", "Show/Hide Debug Sidebar" },
		V = {
			"<cmd>lua local widgets=require'dap.ui.widgets'; widgets.centered_float(widgets.scopes)<CR>",
			"Use widgets to display the variables",
		},
		-- REPEL
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
	},
	-- LSP diagnostics
	D = {
		name = "Diagnostics",
		f = {
			"<cmd>lua vim.diagnostic.open_float()<CR>",
			"Open diagnostics floating",
		},
		p = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Goto prev diagnostics" },
		n = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Goto next diagnostics" },
		l = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Set loclist" },
		w = { ":Telescope diagnostics<CR>", "List diagnostics in worksapce" },
		c = {
			":Telescope diagnostics bufnr=0<CR>",
			"List diagnostics current file",
		},
	},
	-- Running code
	r = {
		name = "Run",
		c = { "<cmd>lua BuiltinTerminalWrapper:create()<CR>", "Create Terminal" },
		o = { "<cmd>lua BuiltinTerminalWrapper:open()<CR>", "Open Terminal" },
		t = { "<cmd>lua BuiltinTerminalWrapper:toggle()<CR>", "Toggle Terminal" },
		C = { "<cmd>lua BuiltinTerminalWrapper:close()<CR>", "Close Terminal" },
		x = { "<cmd>lua BuiltinTerminalWrapper:kill()<CR>", "Kill Terminal" },
		l = {
			'<cmd>lua BuiltinTerminalWrapper:send_command {cmd="lua %"}<CR>',
			"Run lua file",
		},
		d = {
			name = "Django",
			r = {
				'<cmd>lua BuiltinTerminalWrapper:send_command {cmd="python manage.py runserver"}<CR>',
				"Runserver",
			},
			R = {
				'<cmd>lua BuiltinTerminalWrapper:send_command {cmd="python manage.py runserver --noreload"}<CR>',
				"Runserver --noreload",
			},
			s = {
				'<cmd>lua BuiltinTerminalWrapper:send_command {cmd="python manage.py shell"}<CR>',
				"Django Shell",
			},
			S = {
				'<cmd>lua BuiltinTerminalWrapper:send_command {cmd="python manage.py createsuperuser"}<CR>',
				"Create super user",
			},
			c = {
				'<cmd>lua BuiltinTerminalWrapper:send_command {cmd="python manage.py collectstatic"}<CR>',
				"Collect all static files",
			},
			k = {
				'<cmd>lua BuiltinTerminalWrapper:send_command {cmd="npx kill-port 8000"}<CR>',
				"Kill Port",
			},
			m = {
				'<cmd>lua BuiltinTerminalWrapper:send_command {cmd="python manage.py makemigrations"}<CR>',
				"Update DB schema",
			},
			M = {
				'<cmd>lua BuiltinTerminalWrapper:send_command {cmd="python manage.py migrate"}<CR>',
				"Migrate DB",
			},
		},
		p = {
			-- p = { ':TermExec cmd="python %"<CR>', "Run python file" },
			-- d = { ':TermExec cmd="python -m pdb %"<CR>', "Debug python file" },
			-- m = { ':TermExec cmd="nodemon -e py %"<CR>', "Monitor python file" },
			name = "Python",
			r = {
				':update<CR>:exec "!python3" shellescape(@%,1)<CR>',
				"Run Python file",
			},
			d = {
				":update<CR>:sp term://python3 -m pdb %<CR>",
				"Debug Python file",
			},
			n = {
				":update<CR>:sp term://nodemon -e py %<CR>",
				"Monitor the file",
			},
		},
		-- yabs
		y = {
			name = "yabs",
			t = { ":Telescope yabs tasks<CR>", "List yabs tasks" },
			g = { ":Telescope yabs globals_tasks<CR>", "List all yabs tasks" },
			l = {
				":Telescope yabs current_language_tasks<CR>",
				"List yabs tasks for language",
			},
		},
	},
	-- Search files
	s = {
		name = "Search",
		a = { ":Telescope live_grep<CR>", "Live grep" },
		b = { ":Telescope buffers theme=get_dropdown<CR>", "buffers" },
		f = { ":Telescope find_files<CR>", "Find files" },
		g = { ":Telescope git_files<CR>", "Git files" },
		m = { ":Telescope marks<CR>", "Bookmarks" },
		r = { ":Telescope oldfiles<CR>", "Recently open files" },
		h = { ":Telescope help_tags<CR>", "Help Tags" },
		p = { ":FloatermNew ranger<CR>", "Picture Viewer" },
		w = { ":Telescope live_grep<CR>", "Find word" },
		v = { ":FloatermNew vifm<CR>", "ViFm" },
	},
	-- Files
	F = {
		name = "Files",
		w = { ":w<CR>", "Save" },
		c = { ":bdelete<CR>", "Close" },
		C = { ":q!<CR>", "Quit withou save" },
		e = { ":qa<CR>", "Exit Neovim" },
		E = { ":qa!<CR>", "Exit Neovim without save" },
		q = { ":q<CR>", "Quit" },
	},
	-- Git
	G = {
		name = "Git",
		g = { ":Neogit<CR>", "Neogit" },
		a = { ":Git add .<CR>", "add all" },
		b = { ":Git blame<CR>", "blame" },
		B = { ":GBrowse<CR>", "Browse GitHub repo" },
		c = { ":Git commit<CR>", "commit" },
		d = {
			name = "+Diff",
			h = { ":Gdiffsplit<CR>", "diff split" },
			v = { ":Gvdiffsplit<CR>", "diff vsplit" },
			n = { ":Git diff<CR>", "Normal diff" },
		},
		l = { ":Git log<CR>", "List log with details" },
		L = { ":Git log --oneline<CR>", "List log within one line" },
		p = { ":Git push<CR>", "push" },
		P = { ":Git pull<CR>", "pull" },
		r = { ":GRemove<CR>", "remove" },
		s = { ":Git<CR>", "status" },
		S = { ":GitGutterSignsToggle<CR>", "toggle signs" },
		T = {
			':Git log --no-walk --tags --pretty="%h %d %s" --decorate=full<CR>',
			"List all tags in log",
		},
		z = { ":FloatermNew lazygit<CR>", "Lazygit" },
		-- Gist
		G = {
			name = "gist",
			-- a    = {':Gist -a', 'post a gist anonymously' },
			-- b    = {':Gist -b', 'post gist browser' },
			d = { ":Gist -d<CR>", "delete gist" },
			e = { ":Gist -e<CR>", "edit gist" },
			l = { ":Gist -l<CR>", "list public gists" },
			s = { ":Gist -ls<CR>", "list starred gists" },
			m = { ":Gist -m<CR>", "post a gist with all open buffers" },
			p = { ":Gist -p<CR>", "post public gist" },
			P = { ":Gist -P<CR>", "post private gist" },
		},
	},
	-- utilities
	u = {
		name = "Utilities",
		t = {
			name = "terminal",
			d = { "TermExec python manage.py shell<CR>", "Django-admin Shell" },
			p = { "TermExec python<CR>", "Python shell" },
			n = { "TermExec node<CR>", "Node.js shell" },
			v = {
				"TermExec --wintype='vsplit' --position='right'<CR>",
				"Debug Term...",
			},
		},
		l = {
			name = "LiveServer",
			l = { ":Bracey<CR>", "start live server" },
			L = { ":BraceyStop<CR>", "stop live server" },
			r = { ":BraceyReload<CR>", "web page to be reloaded" },
		},
		m = {
			name = "Markdown",
			m = { ":MarkdownPreview<CR>", "start markdown preview" },
			M = { ":MarkdownPreviewStop<CR>", "stop markdown preview" },
		},
		u = {
			name = "UML",
			v = { ":PlantumlOpen<CR>", "start PlantUML preview" },
			o = {
				":PlantumlSave docs/diagrams/out.png<CR>",
				"export PlantUML diagram",
			},
		},
		f = {
			"TermExec --height=0.7 --width=0.9 --wintype=float vifm<CR>",
			"ViFm",
		},
		r = {
			"TermExec --height=0.7 --width=0.9 --wintype=float ranger<CR>",
			"Ranger",
		},
	},
	-- Window
	w = {
		name = "Windows",
		["-"] = { ":split<CR>", "Horiz. window" },
		["|"] = { ":vsplit<CR>", "Vert. window" },
		i = { ":tabnew %<CR>", "Zoom-in" },
		o = { ":tabclose<CR>", "Zoom-out" },
		c = { ":close<CR>", "Close window" },
		k = { "<C-w>k", "Up window" },
		j = { "<C-w>j", "Down window" },
		h = { "<C-w>h", "Left window" },
		l = { "<C-w>l", "Right window" },
		["<Up>"] = { "<cmd>wincmd -<CR>", "Shrink down" },
		["<Down>"] = { "<cmd>wincmd +<CR>", "Grow up" },
		["<Left>"] = { "<cmd>wincmd <<CR>", "Shrink narrowed" },
		["<Right>"] = { "<cmd>wincmd ><CR>", "Grow widder" },
		w = { ':exe "resize" . (winwidth(0) * 3/2)<CR>', "Increase weight" },
		W = { ':exe "resize" . (winwidth(0) * 2/3)<CR>', "Increase weight" },
		v = {
			':exe "vertical resize" . (winheight(0) * 3/2)<CR>',
			"Increase height",
		},
		V = {
			':exe "vertical resize" . (winheight(0) * 2/3)<CR>',
			"Increase height",
		},
	},
}

local opts = { prefix = "<leader>" }

which_key.register(mappings, opts)

local keymap_v = {
	name = "Debug",
	e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
}
which_key.register(keymap_v, {
	mode = "v",
	prefix = "<Leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
})
