--
require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "copilot",
      -- adapter = "openai",
    },
    inline = {
      adapter = "copilot",
    },
    aggent = {
      adapter = "copilot",
    },
  },
  adapters = {
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        env = {
          api_key = "cmd:op read op://Private/OpenApiToken/credential --no-newline",
        },
        schema = {
          model = {
            default = "gpt-4o-mini",
          },
        },
      })
    end,
  },
})
vim.env["CODECOMPANION_TOKEN_PATH"] = vim.fn.expand("~/.config")
