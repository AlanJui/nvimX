-- telescope.nvim.lua
local status, telescope = pcall(require, "telescope")
if not status then
    return
end

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        -- layout_strategy = "flex",
        -- layout_config = {
        -- 	flex = { flip_columns = 130 },
        -- },
        layout_strategy = "vertical",
        layout_config = {
            width = 0.85,
            height = 0.95,
        },
        mappings = {
            n = { ["q"] = actions.close },
            i = { ["<C-u>"] = false, ["<C-d>"] = false },
        },
        vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
    },
})

-- keymap
-- local keymap = require('utils.set_keymap')
-- local opts = { noremap = true, silent = true }

-- keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
-- keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opts)
-- keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
-- keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
-- keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
-- keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
-- keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
-- keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
-- keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

-- keymap("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
-- keymap("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
-- keymap("n", "<leader>sb", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
-- keymap("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)
