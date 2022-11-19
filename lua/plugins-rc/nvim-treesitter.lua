---------------------------------------------------------------------------
-- Treesitter
-- Can be used for things like highlighting, indentation, folding.
---------------------------------------------------------------------------
-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	-- ensure these language parsers are installed
	-- A list of parser names, or "all"
	ensure_installed = {
		"lua",
		"vim",
		"python",
		"json",
		"javascript",
		"typescript",
		"tsx",
		"css",
		"markdown",
		"svelte",
		"graphql",
		"yaml",
		"toml",
		"html",
		"dockerfile",
		"gitignore",
		"comment",
		"latex",
		"bash",
		"c",
		"cmake",
		"go",
		"rust",
	},
	-- auto install above language parsers
	auto_install = true,
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	autotag = { enable = true },
	-- enable syntax highlighting
	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)

		-- list of language that will be disabled
		-- disable = { "c", "rust" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		-- additional_vim_regex_highlighting = false,
	},
	autopairs = { enable = true },
	context_commentstring = {
		enable = true,
		config = {
			css = "// %s",
			javascript = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
			},
		},
	},
})
