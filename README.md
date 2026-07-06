# nvim-configs
A comprehensive Neovim setup designed for productivity, featuring plugins for code completion, syntax highlighting, file navigation, and more.

## Installation

To set up this Neovim configuration:

1. Install Python dependencies:
    ```
    pip3 install --user -r requirements.txt
    ```
2. Install Ruby dependencies:
    ```
    gem install neovim
    ```
3. Clone the plugin manager:
    ```
    git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
    ```

## Features and Plugins

### **Plugin Management**
- **[minpac](https://github.com/k-takata/minpac)**: A minimalist package manager for managing all plugins.

---

### **UI Enhancements**
- **[vim-airline](https://github.com/vim-airline/vim-airline)**: Provides a customizable status line.
- **[vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)**: Adds themes for vim-airline.
- **[nvim-notify](https://github.com/rcarriga/nvim-notify)**: Displays notifications in Neovim.
- **[vim-devicons](https://github.com/ryanoasis/vim-devicons)**: Adds file type icons to the UI.
- **[github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)**: Provides a GitHub-inspired color scheme.

---

### **File Navigation**
- **[NERDTree](https://github.com/scrooloose/nerdtree)**: A file explorer for navigating your project.
- **[nerdtree-git-plugin](https://github.com/Xuyuanp/nerdtree-git-plugin)**: Adds Git status indicators to NERDTree.
- **[fzf](https://github.com/junegunn/fzf)**: A fuzzy finder for searching files and content.
- **[fzf.vim](https://github.com/junegunn/fzf.vim)**: Integrates fzf with Neovim.
- **[Telescope](https://github.com/nvim-telescope/telescope.nvim)**: A highly extensible fuzzy finder for files, buffers, and more.

---

### **Syntax Highlighting and Parsing**
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**: Provides advanced syntax highlighting and code parsing.

---

### **Code Completion**
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: Configures built-in LSP support for language servers.
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**: A completion engine for Neovim.
- **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)**: A snippet engine for code completion.
- **[cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)**: Integrates LSP with nvim-cmp.
- **[cmp-buffer](https://github.com/hrsh7th/cmp-buffer)**: Adds buffer completions to nvim-cmp.
- **[cmp-path](https://github.com/hrsh7th/cmp-path)**: Adds file path completions to nvim-cmp.
- **[cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)**: Adds command-line completions to nvim-cmp.
- **[friendly-snippets](https://github.com/rafamadriz/friendly-snippets)**: Provides a collection of pre-defined snippets.

---

### **Linting and Formatting**
- **[nvim-lint](https://github.com/mfussenegger/nvim-lint)**: Provides linting support for various languages.

---

### **Git Integration**
- **[vim-fugitive](https://github.com/tpope/vim-fugitive)**: A Git wrapper for Neovim.
- **[vim-git](https://github.com/tpope/vim-git)**: Adds Git-related syntax highlighting.

---

### **Text Editing**
- **[vim-surround](https://github.com/tpope/vim-surround)**: Provides mappings for surrounding text.
- **[vim-repeat](https://github.com/tpope/vim-repeat)**: Enhances the repeat (`.`) command.
- **[vim-commentary](https://github.com/tpope/vim-commentary)**: Simplifies commenting and uncommenting code.
- **[vim-unimpaired](https://github.com/tpope/vim-unimpaired)**: Adds handy mappings for common tasks.
- **[vim-easy-align](https://github.com/junegunn/vim-easy-align)**: Aligns text interactively.

---

### **Language-Specific Plugins**
- **Go**: [vim-go](https://github.com/fatih/vim-go), [vim-delve](https://github.com/sebdah/vim-delve)
- **Python**: [vim-python-pep8-indent](https://github.com/Vimjas/vim-python-pep8-indent), [python-syntax](https://github.com/vim-python/python-syntax)
- **Ruby**: [vim-ruby](https://github.com/vim-ruby/vim-ruby), [rspec.vim](https://github.com/sheerun/rspec.vim)
- **Docker**: [Dockerfile.vim](https://github.com/ekalinin/Dockerfile.vim)
- **Markdown**: [vim-markdown](https://github.com/plasticboy/vim-markdown)
- **YAML**: [vim-yaml-folds](https://github.com/pedrohdz/vim-yaml-folds)

---

### **AI and Productivity**
- **[minuet-ai.nvim](https://github.com/milanglacier/minuet-ai.nvim)**: Provides Copilot-style ghost-text inline completions backed by local [Ollama](https://ollama.com) using FIM (fill-in-the-middle) completions (model: `qwen2.5-coder:1.5b`). Keymaps: `<C-j>` accept, `<C-l>` accept line, `<C-K>` next, `<C-e>` dismiss.
- **[codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)**: AI-powered chat and inline editing assistant. Chat uses Ollama (`qwen3.6:35b-a3b-nvfp4`); other adapters (Gemini, OpenAI) available.

## Ollama Service Setup

Both AI plugins talk to a local Ollama server, installed and run as a
Homebrew service (`brew services` / launchd). Out of the box that service
works poorly for this setup:

- Ollama unloads a model **5 minutes** after its last request, so the
  completion model cold-starts constantly.
- The completion model (`qwen2.5-coder:1.5b`, minuet) and the chat model
  (`qwen3.6:35b-a3b-nvfp4`, codecompanion) need to be resident at the same
  time, or loading one can evict the other.

Run the setup script to fix this:

```
scripts/ollama-service.sh
```

It edits the service plist (launchd services don't read your shell profile,
so the env vars must live there), restarts the service, warms both models,
and finishes with `ollama ps` so you can confirm both models show an `UNTIL`
of ~4 hours. Pass model names as arguments to warm different models instead.

The environment variables it sets:

| Variable | Value | Why |
|----------|-------|-----|
| `OLLAMA_KEEP_ALIVE` | `4h` | Keep models loaded for 4 hours after last use instead of the 5 minute default. |
| `OLLAMA_MAX_LOADED_MODELS` | `2` | Guarantee the completion and chat models can be resident together. |
| `OLLAMA_FLASH_ATTENTION` | `1` | Tiled attention implementation: same outputs, less memory, faster at long context. Required for KV cache quantization. |
| `OLLAMA_KV_CACHE_TYPE` | `q8_0` | Store the KV cache in 8-bit instead of f16, roughly halving its memory footprint with negligible quality loss. Matters because the cache is allocated per loaded model and the chat model's can run to multiple GB. |

`OLLAMA_KEEP_ALIVE` and `OLLAMA_MAX_LOADED_MODELS` can be overridden by
exporting them before running the script.

> **Important:** `brew upgrade ollama` regenerates the plist and silently
> wipes all of these settings. Re-run the script after every upgrade (it's
> idempotent). Symptoms of a stale plist: completions lag because the model
> cold-starts, or `ollama --version` reports a client/server version
> mismatch because the service is still running the old binary.

## Key Mappings

### AI Completions (minuet-ai — insert mode)

| Key | Action |
|-----|--------|
| `<C-j>` | Accept full suggestion |
| `<C-l>` | Accept one line |
| `<C-K>` | Next suggestion |
| `<C-H>` | Previous suggestion |
| `<C-e>` | Dismiss suggestion |
| `<leader>mt` | Toggle completions on/off |

### AI Chat (CodeCompanion)

| Key | Action |
|-----|--------|
| `<leader>fc` | Browse prompt library (Telescope) |

### LSP (active when a language server is attached)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | List references |
| `K` | Hover docs |
| `<C-k>` | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>D` | Type definition |
| `<leader>f` | Format buffer |
| `<leader>e` | Show diagnostics float |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>q` | Send diagnostics to loclist |

### Telescope

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fG` | Grep word under cursor |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |

### Trouble (diagnostics)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics |
| `<leader>xl` | Toggle loclist |
| `<leader>xq` | Toggle quickfix |

### DiffView

| Key | Action |
|-----|--------|
| `<leader>dv` | Open diff view |
| `<leader>dc` | Close diff view |
| `<leader>df` | File history |

### Snippets (LuaSnip — insert/select mode)

| Key | Action |
|-----|--------|
| `<Tab>` | Expand snippet or jump forward |
| `<S-Tab>` | Jump backward |
| `<C-E>` | Cycle snippet choices |

---

## Language Servers

LSP servers are managed by your system package manager — no Neovim plugin required. The configured servers and how to install them:

| Server | Language | Install command |
|--------|----------|----------------|
| `lua_ls` | Lua | `brew install lua-language-server` |
| `rust_analyzer` | Rust | `rustup component add rust-analyzer` |
| `jedi_language_server` | Python | `pip install jedi-language-server` |
| `yamlls` | YAML | `brew install yaml-language-server` |
| `bashls` | Bash | `brew install bash-language-server` |
| `helm_ls` | Helm | `brew install helm-ls` |
| `jsonls` | JSON | `brew install vscode-langservers-extracted` |
| `html` | HTML | `brew install vscode-langservers-extracted` |
| `cssls` | CSS | `brew install vscode-langservers-extracted` |
| `eslint` | JavaScript/TypeScript | `brew install vscode-langservers-extracted` |
| `marksman` | Markdown | `brew install marksman` |

Linters used by `nvim-lint` also need to be installed:

| Linter | Install command |
|--------|----------------|
| `shellcheck` | `brew install shellcheck` |

### Check Installed Language Servers
Run the following command in Neovim to see the status of active language servers:
```
:LspInfo
```

---
## License

This repository is licensed under the MIT License. See the `LICENSE` file for details.
