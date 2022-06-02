-- material.lua
-- Lualine has sections as shown below.
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

local ok1, tabline = pcall(require, 'tabline')
if not ok1 then
  return
end

local lsp_provider = require('utils/lsp').lsp_provider

--------------------------------------------------------
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added    = gitsigns.added,
      modified = gitsigns.changed,
      removed  = gitsigns.removed
    }
  end
end

-- Color for highlights
local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local config = {
  options = {
    icons_enabled = true,
    theme = 'tokyonight' or 'material',
    -- theme = vim.g.colors_name or 'auto',
    disabled_filetypes = { 'dashboard', 'NvimTree', 'packer' },
    -- component_separators = {'', ''},
    -- section_separators = {'', ''},
    -- always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      'mode',
      -- fmt = function (str)
        -- 	return str:sub(1,1)
        -- end
      },
      lualine_b = {
        'branch',
        {
          'diff',
          source = diff_source
        },
        {
          -- table of diagnostic sources, available sources:
          -- 'nvim_lsp', 'nvim', 'coc', 'ale', 'vim_lsp'
          -- Or a function that returns a table like:
          -- {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
          'diagnostics',
          sources = { 'nvim_diagnostic', 'coc', 'ale' },
          -- displays diagnostics from defined severity
          sections = {'error', 'warn', 'info', 'hint'},
          -- all colors are in format #rrggbb
          diagnostic_color = {
            error = nil,
            warn  = nil,
            info  = nil,
            hint  = nil,
          },
          symbols = {
            error = ' ',
            warn  = ' ',
            info  = ' ',
            hint  = ' ',
          },
          -- Update diagnostics in insert mode
          update_in_insert = false,
          -- Show diagnostics even if count is 0
          alwayw_visible = false,
        }
      },
      lualine_c = {
        'filename',
      },
      lualine_x = {
        'filetype',
        lsp_provider,
      },
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { tabline.tabline_buffers },
      lualine_x = { tabline.tabline_tabs },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {'fugitive'}
  }

  --------------------------------------------------------
  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x ot right section
  -- local function ins_right(component)
    --     table.insert(config.sections.lualine_x, component)
    -- end

    ins_left({
      'lsp_progress',
      display_components = {
        'lsp_client_name',
        'spinner',
        { 'title', 'percentage', 'message' }
      },
      -- With spinner
      -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
      colors = {
        percentage  = colors.cyan,
        title  = colors.cyan,
        message  = colors.cyan,
        spinner = colors.cyan,
        lsp_client_name = colors.magenta,
        use = true,
      },
      separators = {
        component = ' ',
        progress = ' | ',
        message = { pre = '(', post = ')'},
        -- message = { commenced = 'In Progress', completed = 'Completed' },
        percentage = { pre = '', post = '%% ' },
        title = { pre = '', post = ': ' },
        lsp_client_name = { pre = '[', post = ']' },
        spinner = { pre = '', post = '' },
      },
      timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
      spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
    })

    lualine.setup({
      options = config.options,
      sections = config.sections,
      inactive_sections = config.inactive_sections,
      tabline = config.tabline,
      extensions = config.extensions,
    })
