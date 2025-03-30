local notify = require("notify")

local function show_spell_suggestions()
    local word = vim.fn.expand("<cword>") -- Get the current word under the cursor
    local suggestions = vim.fn.spellsuggest(word)

    -- Define floating window dimensions
    local width = math.floor(vim.o.columns * 0.4)
    local height = math.floor(vim.o.lines * 0.3)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create a new buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, suggestions)

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded"
    })

    -- Map <CR> to replace the word with the selected suggestion
    vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", ":lua apply_suggestion()<CR>", { noremap = true, silent = true })


    -- Store the word being replaced and suggestions for later use
    vim.b.floating_spell_word = word
    vim.b.floating_spell_suggestions = suggestions
end

function apply_suggestion()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local suggestion = vim.b.floating_spell_suggestions[line]
    if suggestion then
        vim.cmd("normal ciw" .. suggestion)
        notify("Replaced '" .. vim.b.floating_spell_word .. "' with '" .. suggestion .. "'", "info", { title = "Spelling Corrected" })
    end
    vim.api.nvim_win_close(0, true)
end

-- Create a user command to trigger spell suggestions
vim.api.nvim_create_user_command("SpellSuggest", show_spell_suggestions, {})

-- Keybinding to trigger the interactive spell picker
vim.api.nvim_set_keymap("n", "<leader>ss", ":SpellSuggest<CR>", { noremap = true, silent = true })

-- Enable spell checking
vim.cmd("set spell spelllang=en_us")

return {
    show_spell_suggestions = show_spell_suggestions,
    apply_suggestion = apply_suggestion
}
