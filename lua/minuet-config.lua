local ok, minuet = pcall(require, "minuet")
if not ok then
  vim.notify("minuet-ai not available: " .. minuet, vim.log.levels.WARN)
  return
end

minuet.setup({
  -- openai_fim_compatible uses the /v1/completions endpoint with FIM tokens,
  -- which is the right approach for inline code completion models.
  provider = "openai_fim_compatible",
  context_window = 4096,
  -- Suppress repeated popups when Ollama is unreachable
  notify_on_error = true,
  -- Debounce: wait 1s after typing before firing a request
  throttle = 1000,
  -- Keep in sync with nvim-cmp's performance.fetching_timeout (see nvim-cmp.lua).
  request_timeout = 3,
  -- Manual cmp invocation only needs one candidate.
  n_completions = 1,
  provider_options = {
    openai_fim_compatible = {
      -- Use the -base model: instruct models return prose instead of clean FIM completions.
      model = "qwen2.5-coder:1.5b-base",
      end_point = "http://localhost:11434/v1/completions",
      -- Ollama doesn't need a real key; TERM is always set in the environment
      api_key = "TERM",
      name = "Ollama",
      stream = true,
      optional = {
        max_tokens = 256,
        top_p = 0.9,
      },
    },
  },
})

-- nvim-cmp integration: minuet registers a "minuet" cmp source automatically
-- during setup() above. It is wired into nvim-cmp (source + manual <A-y> keymap)
-- in lua/nvim-cmp.lua.
