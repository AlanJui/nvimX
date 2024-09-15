return {
  -- Open URI with your favorite browser from Neovim
  {
    "tyru/open-browser.vim",
    lazy = false,
    ft = { "plantuml" },
  },
  -- PlantUML syntax highlighting
  {
    "aklt/plantuml-syntax",
    lazy = false,
    ft = { "plantuml" },
  },
  -- provides support to mermaid syntax files (e.g. *.mmd, *.mermaid)
  {
    "mracos/mermaid.vim",
    lazy = false,
    ft = { "mermaid", "markdown" },
  },
  -- Markdown Syntax Highlighting
  -- URL: https://github.com/preservim/vim-markdown
  {
    "preservim/vim-markdown",
    config = function()
      -- 變更預設：文件內容毋需折疊
      vim.g.vim_markdown_folding_disabled = 1
      -- vim.g.markdown_fenced_languages = {
      --   "html",
      --   "python",
      --   "bash=sh",
      -- }
      -- disabling conceal for code fences
      -- vim.g.markdown_conceal_code_blocks = 0
    end,
  },
  -- Live server
  -- {
  --   "turbio/bracey.vim",
  --   build = "npm install --prefix server",
  -- },
  -- Preview markdown file
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    keys = {
      { "<leader>um", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Previewer" },
    },
    -- build = function() vim.fn["mkdp#util#install"]() end,
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = "9999"
    end,
    ft = { "markdown" },
    -- setup = function()
    --   vim.cmd([[
    --     let g:mkdp_filetypes = { "markdown" }
    --     let g:mkdp_auto_start = 0
    --     let g:mkdp_auto_close = 1
    --     let g:mkdp_command_for_global = 0
    --     let g:mkdp_open_to_the_world = 0
    --     let g:mkdp_open_ip = "127.0.0.1"
    --     let g:mkdp_port = "9999"
    --     let g:mkdp_filetypes = { "markdown" }
    --     let g:mkdp_browserfunc = ""
    --     let g:mkdp_preview_options = {
    --         \ 'mkit': {},
    --         \ 'katex': {},
    --         \ 'uml': {},
    --         \ 'maid': {},
    --         \ 'disable_sync_scroll': 0,
    --         \ 'sync_scroll_type': 'middle',
    --         \ 'hide_yaml_meta': 1,
    --         \ 'sequence_diagrams': {},
    --         \ 'flowchart_diagrams': {},
    --         \ 'content_editable': v:false,
    --         \ 'disable_filename': 0,
    --         \ 'toc': {}
    --         \ }
    --     let g:mkdp_markdown_css = ""
    --     let g:mkdp_highlight_css = ""
    --     let g:mkdp_page_title = "${name}"
    --   ]])
    -- end,
  },
  -- PlantUML
  {
    "weirongxu/plantuml-previewer.vim",
    ft = { "plantuml" },
    dependices = {
      {
        -- Open URI with your favorite browser from Neovim
        "tyru/open-browser.vim",
        -- PlantUML syntax highlighting
        "aklt/plantuml-syntax",
        -- provides support to mermaid syntax files (e.g. *.mmd, *.mermaid)
        "mracos/mermaid.vim",
      },
    },
    cmd = { "PlantumlOpen", "PlantumlSave", "PlantumlToggle" },
    keys = {
      { "<leader>up", "<cmd>PlantumlToggle<cr>", desc = "Toggle PUML Previewer" },
    },
    config = function()
      vim.g.my_jar_path = vim.fn.stdpath("data") .. "/lazy/plantuml-previewer.vim/lib/plantuml.jar"
      vim.cmd([[
        autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = g:my_jar_path
        let g:plantuml_previewer#save_format = "png"
        let g:plantuml_previewer#debug_mode = 1
      ]])
    end,
  },
}
