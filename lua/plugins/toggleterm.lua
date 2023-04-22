return {
  "akinsho/toggleterm.nvim",
  keys = {
    { [[<C-t>]] },
    {
      "<leader>0",
      "<cmd>2ToggleTerm<cr>",
      desc = "Terminal #2",
    },
    {
      "<leader>gg",
      "<cmd>lua _G.lazygit_toggle()<cr>",
      desc = "LazyGit",
    },
    {
      "<leader>fv",
      "<cmd>Vifm<cr>",
      desc = "ViFm",
    },
    {
      "<leader>gS",
      ":2TermExec cmd='git status'<cr>",
      desc = "git status",
    },
  },
  cmd = { "ToggleTerm", "TermExec" },
  opts = {
    size = 20,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
    shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    shading_factor = "0.3", -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    direction = "float",
    shell = vim.o.shell,
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
  },
  config = function()
    require("toggleterm").setup()

    local Terminal = require("toggleterm.terminal").Terminal

    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      ---@diagnostic disable-next-line: unused-local
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      ---@diagnostic disable-next-line: unused-local
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _G.lazygit_toggle()
      lazygit:toggle()
    end

    vim.cmd([[
      " set
      autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

      " By applying the mappings this way you can pass a count to your
      " mapping to open a specific window.
      " For example: 2<C-t> will open terminal 2
      nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
      inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
    ]])

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
