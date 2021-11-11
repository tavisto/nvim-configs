-- in tools.lua
local api = vim.api

local M = {}

function M.makeScratch()
  api.nvim_command('vnew') -- equivalent to :enew
  vim.bo.filetype='lua'
end

return M
