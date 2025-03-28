require('telescope').setup{
  defaults = {
    prompt_prefix = "🔍 ",
    selection_caret = "➜ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {"truncate"},
    winblend = 20,  -- Set transparency
    border = true,
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },  -- Rounded corners
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    mappings = {
      i = {
        ["<C-n>"] = require('telescope.actions').move_selection_next,
        ["<C-p>"] = require('telescope.actions').move_selection_previous,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",  -- Use dropdown theme for a compact look
    },
    live_grep = {
      theme = "ivy",  -- Use ivy theme for a different style
    },
  },
  extensions = {
    -- Configure extensions here
  },
}
