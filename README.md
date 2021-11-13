# nvim-configs
My neovim setup

## Move in
```
    pip3 install --user -r requirements.txt
    gem install neovim
    git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac
```

## Commands

* Open all files in their own windows `vim -O file1 file2`

## Search

* [Telescope](https://github.com/nvim-telescope/telescope.nvim)

## Syntax

* [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)


## Completion

* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
* [Friendly Snippets](https://github.com/rafamadriz/friendly-snippets)

Just hit tab to pull up the list, then enter to accept.

## Language servers

To show which language servers are installed
```
:LspInfo
```

### NPM using the package.json

```
npm install
```

### Cargo for rust basesd servers

```
cargo install taplo-lsp
```
