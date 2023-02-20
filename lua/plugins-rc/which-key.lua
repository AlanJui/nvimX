--------------------------------------------------------------------------
-- WhichKey Configuration
--------------------------------------------------------------------------
local status, which_key = pcall(require, "which-key")
if not status then
	print("which-key not loaded")
	return
end

local mappings = {
	-- Top Menu
	[" "] = { ":Telescope find_files<CR>", "Find files" },
	[","] = { ":Telescope buffers<CR>", "Show buffers" },
	["."] = { "<cmd>lua _lazygit_toggle()<CR>", "Lazygit" },
	[";"] = { ":ToggleTerm size=10<CR>", "Open Terminal" },
	["/"] = { "gcc", "Comment out (Toggle)" },
	["\\"] = { ":NvimTreeToggle<CR>", "File explorer" },
	["e"] = { ":Vifm<CR>", "Files manager" },
	["q"] = {
		":FloatermNew --height=0.7 --width=0.9 --wintype=float  ranger<CR>",
		"Quick viewer",
	},
	["U"] = { "UndotreeToggle<CR>", "Undo tree" },
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
	-- Files
	f = {
		name = "Files",
		e = { ":NvimTreeToggle<CR>", "File explorer" },
		w = { ":w<CR>", "Save" },
		i = { "gg=G", "Formate indent of line" },
		b = {
			name = "Buffers",
			l = { ":Telescope buffers<CR>", "List all buffers" },
			p = { "gT", "Prev. buffer" },
			n = { "gt", "Next buffer" },
		},
		c = {
			name = "Close",
			c = { ":bdelete<CR>", "Close" },
			b = { '%bdelete|edit #|normal `"<CR>', "Close all but current" },
		},
		q = {
			name = "Quit/Exit",
			["!"] = { ":q!<CR>", "Quit withou save" },
			q = { ":q<CR>", "Quit" },
			x = { ":qa<CR>", "Exit Neovim" },
			X = { ":qa!<CR>", "Exit Neovim without save" },
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
	},
	-- Build (yabs)
	b = {
		name = "Build...",
		t = {
			name = "Run tasks with Telescope",
			t = { ":Telescope yabs tasks<CR>", "List yabs tasks" },
			g = { ":Telescope yabs globals_tasks<CR>", "List all yabs tasks" },
			l = {
				":Telescope yabs current_language_tasks<CR>",
				"List yabs tasks for language",
			},
		},
		c = { ":Telescope yabs current_language_tasks<CR>", "Tasks for current language" },
		d = {
			"<cmd>lua require('yabs'):run_default_task()<CR>",
			"Run default task",
		},
		l = { "<cmd>lua require('yabs'):run_task('lint')<CR>", "Lint task" },
		b = { "<cmd>lua require('yabs'):run_task('build')<CR>", "Build task" },
		r = { "<cmd>lua require('yabs'):run_task('run')<CR>", "Run task" },
		p = { "<cmd>lua require('yabs'):run_task()<CR>", "Tasks for Project" },
	},
	-- Coding
	c = {
		name = "Coding",
		a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Do CodeAction" },
		A = {
			"<cmd>lua vim.lsp.buf.range_code_action()<CR>",
			"Do Range CodeAction",
		},
		-- LSP diagnostics
		d = {
			":Telescope diagnostics bufnr=0<CR>",
			"List diagnostics current file",
		},
		D = {
			name = "Diagnostics",
			l = {
				name = "LspSaga",
				b = { "<cmd>Lspsaga show_buf_diagnostics<CR>", "Show buffer diagnostics" },
				c = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostics" },
				l = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics" },
			},
			w = { ":Telescope diagnostics<CR>", "List diagnostics in worksapce" },
			c = {
				":Telescope diagnostics bufnr=0<CR>",
				"List diagnostics current file",
			},
			f = {
				"<cmd>lua vim.diagnostic.open_float()<CR>",
				"Open diagnostics floating",
			},
			p = {
				"<cmd>lua vim.diagnostic.goto_prev()<CR>",
				"Goto prev diagnostics",
			},
			n = {
				"<cmd>lua vim.diagnostic.goto_next()<CR>",
				"Goto next diagnostics",
			},
		},
		f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Formatting code" },
		k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show HoverDocument" },
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename code" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature help" },
		g = {
			name = "goto",
			D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
			d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
			p = { ":Lspsaga peek_definition<CR>", "Peek definition" },
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
		u = { "<cmd>lua vim.cmd.UndotreeToggle()<CR>", "Toggle Undotree" },
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
	-- Git
	g = {
		name = "Git",
		g = { ":Neogit<CR>", "Neogit" },
		a = { ":Git add .<CR>", "add all" },
		b = { ":Git blame<CR>", "blame" },
		B = { ":GBrowse<CR>", "Browse GitHub repo" },
		c = { ":Git commit<CR>", "commit" },
		d = { ":Gvdiffsplit<CR>", "diff vsplit" },
		D = {
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
	-- Running code
	r = {
		name = "Run...",
		p = {
			name = "Python",
			p = {
				":TermExec direction=horizontal cmd='python %'<CR>",
				"Run current file",
			},
			l = {
				":TermExec direction=horizontal cmd='pylint %'<CR>",
				"Lint current file",
			},
		},
		d = {
			name = "Django...",
			k = { ":2TermExec cmd='npx kill-port 8000'<CR>", "Kill Port" },
			g = { ":2TermExec cmd='git status'<CR>", "git status" },
			r = { ":TermExec cmd='poetry run python manage.py runserver'<CR>", "Runserver" },
			R = {
				":TermExec cmd='poetry run python manage.py runserver --noreload'<CR>",
				"Runserver --noreload",
			},
			S = { ":2TermExec cmd='poetry run python manage.py shell'<CR>", "Django Shell" },
			s = {
				":2TermExec cmd='poetry run python manage.py createsuperuser'<CR>",
				"Create super user",
			},
			c = {
				":2TermExec cmd='echo yes | poetry run python manage.py collectstatic --noinput'<CR>",
				"Collect all static files",
			},
			m = {
				":2TermExec cmd='poetry run python manage.py makemigrations'<CR>",
				"Update DB schema",
			},
			M = { ":2TermExec cmd='poetry run python manage.py migrate'<CR>", "Migrate DB" },
		},
	},
	-- Terminal
	t = {
		name = "Terminal",
		c = { "<cmd>lua BuiltinTerminalWrapper:create()<CR>", "Create Terminal" },
		o = { "<cmd>lua BuiltinTerminalWrapper:open()<CR>", "Open Terminal" },
		C = { "<cmd>lua BuiltinTerminalWrapper:close()<CR>", "Close Terminal" },
		x = { "<cmd>lua BuiltinTerminalWrapper:kill()<CR>", "Kill Terminal" },
		-- t = { "<cmd>lua BuiltinTerminalWrapper:toggle()<CR>", "Toggle Terminal" },
		h = {
			":ToggleTerm size=15 direction=horizontal<CR>",
			"Toggle horizontal terminal",
		},
		v = {
			":ToggleTerm size=" .. (vim.o.columns * 0.5) .. " direction=vertical<CR>",
			"Toggle vertical terminal",
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
		["_"] = { ":vsplit<CR>", "Vert. window" },
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
	-- Trouble List
	z = {
		name = "Trouble",
		x = { ":TroubleToggle<CR>", "On/Off TroubleToggle" },
		r = { ":TroubleToggle lsp_references<CR>", "Display LSP References" },
		q = { ":TroubleToggle quickfix<CR>", "List QuickFix" },
		w = {
			":TroubleToggle workspace_diagnostics<CR>",
			"List diatnostics of workspace",
		},
		d = {
			":TroubleToggle document_diagnostics<CR>",
			"List diatnostics of current file",
		},
		l = { ":TroubleToggle loclist<CR>", "List loclist" },
		j = {
			name = "Jump",
			f = {
				'<cmd>lua require("trouble").first({skip_groups = true, jump = true})',
				"Jump to the first item, skipping the groups",
			},
			p = {
				'<cmd>lua require("trouble").previous({skip_groups = true, jump = true})',
				"Jump to the previous item, skipping the groups",
			},
			n = {
				'<cmd>lua require("trouble").next({skip_groups = true, jump = true})<CR>',
				"Jump to the next item, skipping the groups",
			},
			l = {
				'<cmd>lua require("trouble").last({skip_groups = true, jump = true})',
				"Jump to the last item, skipping the groups",
			},
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

which_key.setup({
	-- enable this to hide mappings for which you didn't specify a label
	ignore_missing = true,
})
