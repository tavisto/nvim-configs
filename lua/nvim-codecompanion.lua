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
        border = "solid",
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
      -- adapter = "copilot",
      -- adapter = "gemini",
      -- adapter = "openai",
      -- adapter = "apfel",
      -- adapter = "opencode",
      adapter = "ollama",
    },
    inline = {
      adapter = "gemini",
    },
  },
  adapters = {
    acp = {
      opencode = "opencode",
    },
    http = {
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
              default = "gemma4",
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
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "cmd:op read op://Private/Gemini/key --no-newline",
          },
          schema = {
            model = {
              default = "gemini-2.5-flash-lite",
            },
          },
        })
      end,
    },
  },
  prompt_library = {
    default = {
      prompt = "You are a helpful assistant. Answer the question as truthfully as possible, and if you don't know the answer, say 'I don't know'.",
      temperature = 0.5,
      max_tokens = 1000,
      top_p = 1,
      frequency_penalty = 0,
      presence_penalty = 0,
    },
  },
})
vim.env["CODECOMPANION_TOKEN_PATH"] = vim.fn.expand("~/.config")
