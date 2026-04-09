-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  vim.keymap.set('n', 'gD',         vim.lsp.buf.declaration,                opts)
  vim.keymap.set('n', 'gd',         vim.lsp.buf.definition,                 opts)
  vim.keymap.set('n', 'K',          vim.lsp.buf.hover,                      opts)
  vim.keymap.set('n', 'gi',         vim.lsp.buf.implementation,             opts)
  vim.keymap.set('n', '<C-k>',      vim.lsp.buf.signature_help,             opts)
  vim.keymap.set('n', '<leader>D',  vim.lsp.buf.type_definition,            opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,                     opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,                opts)
  vim.keymap.set('n', 'gr',         vim.lsp.buf.references,                 opts)
  vim.keymap.set('n', '<leader>e',  vim.diagnostic.open_float,              opts)
  vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev,               opts)
  vim.keymap.set('n', ']d',         vim.diagnostic.goto_next,               opts)
  vim.keymap.set('n', '<leader>q',  vim.diagnostic.setloclist,              opts)
  vim.keymap.set('n', '<leader>f',  function() vim.lsp.buf.format() end,    opts)
end

-- Register Helm filetypes so helm_ls can attach correctly
vim.filetype.add({
  pattern = {
    ['helmfile.*%.ya?ml'] = 'helm',
    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['.*/templates/.*%.tpl'] = 'helm',
    ['.*/chart/.*values.*%.ya?ml'] = 'yaml.helm-values',
    ['values.*%.ya?ml'] = 'yaml.helm-values',
  },
})

-- LSP servers installed via system package managers:
--   lua_ls:               brew install lua-language-server
--   rust_analyzer:        rustup component add rust-analyzer
--   jedi_language_server: pip install jedi-language-server
--   yamlls:               brew install yaml-language-server
--   bashls:               brew install bash-language-server
--   helm_ls:              brew install helm-ls
--   jsonls, html, cssls, eslint: brew install vscode-langservers-extracted
--   marksman:             brew install marksman

-- Apply on_attach and capabilities globally to all servers
vim.lsp.config('*', {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Server-specific overrides
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

vim.lsp.enable({ 'lua_ls', 'rust_analyzer', 'jedi_language_server', 'yamlls', 'bashls', 'helm_ls', 'jsonls', 'html', 'cssls', 'eslint', 'marksman' })

return {
  on_attach = on_attach,
}
