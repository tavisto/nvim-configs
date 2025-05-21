--
require("codecompanion").setup({
  display = {
    chat = {
      -- Change the default icons
      icons = {
        pinned_buffer = " ",
        watched_buffer = "👀 ",
      },

      -- Options to customize the UI of the chat buffer
      window = {
        layout = "vertical", -- float|vertical|horizontal|buffer
        position = "left", -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
        border = "single",
        height = 0.8,
        width = 0.45,
        relative = "editor",
        opts = {
          breakindent = true,
          cursorcolumn = false,
          cursorline = false,
          foldcolumn = "0",
          linebreak = true,
          list = false,
          numberwidth = 1,
          signcolumn = "no",
          spell = false,
          wrap = true,
        },
      },

    },

    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ", -- Prompt used for interactive LLM calls
      provider = "telescope", -- default|telescope|mini_pick
      opts = {
        show_default_actions = true, -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      },
    },
  },
  strategies = {
    chat = {
      adapter = "copilot",
      -- adapter = "openai",
      -- adapter = "ollama",
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
    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        env = {
          url = "http://localhost:11434",
        },
        schema = {
          model = {
            default = "codellama:latest",
          },
        },
        headers = {
          ["Content-Type"] = "application/json",
        },
        parameters = {
          sync = true,
        },
      })
    end,
  },
})
vim.env["CODECOMPANION_TOKEN_PATH"] = vim.fn.expand("~/.config")
