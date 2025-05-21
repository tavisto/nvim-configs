require("mason").setup()
-- Note: `nvim-lspconfig` needs to be in 'runtimepath' by the time you set up mason-lspconfig.nvim
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "terraformls",
    "jedi_language_server",
    "ruby_lsp",
    "puppet",
    "bashls",
  }
}
