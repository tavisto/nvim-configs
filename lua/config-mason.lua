require("mason").setup()

local lsp_defaults = require('nvim-lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

local servers = {
  "lua_ls",
  "rust_analyzer",
  "terraformls",
  "jedi_language_server",
  "ruby_lsp",
  "puppet",
  "bashls",
}

require("mason-lspconfig").setup {
  ensure_installed = servers,
  handlers = {
    -- The first entry is the default handler to be used for each server.
    function(server_name)
      require('lspconfig')[server_name].setup {
        on_attach = lsp_defaults.on_attach,
        capabilities = cmp_nvim_lsp.default_capabilities(),
      }
    end,
    -- Next, you can provide targeted overrides for specific servers.
    ["lua_ls"] = function()
      require('lspconfig').lua_ls.setup {
        on_attach = lsp_defaults.on_attach,
        capabilities = cmp_nvim_lsp.default_capabilities(),
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' }
            }
          }
        }
      }
    end,
  }
}
