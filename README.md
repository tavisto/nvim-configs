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

### **Language Server Management**
- **[mason.nvim](https://github.com/williamboman/mason.nvim)**: Manages LSP servers, linters, and formatters.
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)**: Bridges Mason with nvim-lspconfig.

---

### **Linting and Formatting**
- **[nvim-lint](https://github.com/mfussenegger/nvim-lint)**: Provides linting support for various languages.
- **[null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)**: Integrates external formatters and linters with Neovim.

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
- **Terraform**: [vim-terraform](https://github.com/hashivim/vim-terraform)
- **Docker**: [Dockerfile.vim](https://github.com/ekalinin/Dockerfile.vim)
- **Markdown**: [vim-markdown](https://github.com/plasticboy/vim-markdown)
- **YAML**: [vim-yaml-folds](https://github.com/pedrohdz/vim-yaml-folds)

---

### **AI and Productivity**
- **[github/copilot.vim](https://github.com/github/copilot.vim)**: Provides AI-assisted code suggestions.
- **[codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)**: Adds AI-powered coding assistance.

## Language Servers

### Check Installed Language Servers
Run the following command in Neovim to see the status of installed language servers:
```
:LspInfo
```

### Install Language Servers Using Mason
The [Mason](https://github.com/williamboman/mason.nvim) plugin simplifies the installation and management of language servers, linters, and formatters.

1. Open Mason's UI in Neovim:
    ```
    :Mason
    ```

2. Use the Mason UI to browse and install the desired language servers, linters, or formatters. For example:
    - `lua-language-server`
    - `pyright` (Python)
    - `rust-analyzer` (Rust)

3. Once installed, Mason automatically integrates with `nvim-lspconfig` to configure the language servers.

### Manual Installation (Optional)
If you prefer manual installation, you can still use the following methods:

#### Using NPM
Install language servers defined in `package.json`:
```
npm install
```

#### Using Cargo (for Rust-based servers)
Example:
```
cargo install taplo-lsp
```

---
## License

This repository is licensed under the MIT License. See the `LICENSE` file for details.
