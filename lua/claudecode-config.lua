local ok, claudecode = pcall(require, "claudecode")
if not ok then
  vim.notify("claudecode.nvim not available: " .. claudecode, vim.log.levels.WARN)
  return
end

-- Runs the real `claude` CLI in a side split and shares the current file,
-- selection and diagnostics with it. Uses the existing `claude` login.
claudecode.setup({
  terminal = {
    provider = "native",
    split_side = "right",
    split_width_percentage = 0.40,
  },
})

-- Keymaps use the <leader>c prefix: <leader>a (Aerial) and <leader>ca (LSP code
-- action) are already taken, so avoid those two.
vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<CR>", { desc = "Toggle Claude Code" })
vim.keymap.set("n", "<leader>cf", "<cmd>ClaudeCodeFocus<CR>", { desc = "Focus Claude Code" })
vim.keymap.set("n", "<leader>cb", "<cmd>ClaudeCodeAdd %<CR>", { desc = "Add current file to Claude" })
vim.keymap.set("v", "<leader>cs", "<cmd>ClaudeCodeSend<CR>", { desc = "Send selection to Claude" })
vim.keymap.set("n", "<leader>cy", "<cmd>ClaudeCodeDiffAccept<CR>", { desc = "Accept Claude diff" })
vim.keymap.set("n", "<leader>cn", "<cmd>ClaudeCodeDiffDeny<CR>", { desc = "Reject Claude diff" })
