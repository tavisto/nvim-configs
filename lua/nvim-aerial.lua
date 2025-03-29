require("aerial").setup({
  layout = {
    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    -- Enum: prefer_right, prefer_left, right, left, float
    default_direction = "left",
  },
})

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
