-- nvim-treesitter main branch (Neovim 0.12+)
-- The old nvim-treesitter.configs API is gone. Highlighting is handled by
-- Neovim's built-in vim.treesitter; this plugin is now a parser/query manager.
require('nvim-treesitter').setup()

-- Enable treesitter highlighting and indent for every filetype that has a parser.
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
    if pcall(require, 'nvim-treesitter') then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
