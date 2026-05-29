# yeci.nvim

A Neovim configuration for the [yeci](https://yeci.org) development container.

### Plugins

- **[larn.nvim](https://github.com/tourcoder/larn.nvim)** — color theme
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** — status line
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** — syntax highlighting
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** — fuzzy finder
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** +
**[mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)** — LSP server management
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** — git change indicators
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** — file tree

### Key Bindings

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>e` | Toggle file tree |

### Usage

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) and will be installed automatically on
first launch.

```bash
git clone --depth=1 https://github.com/tourcoder/yeci.nvim.git ~/.config/nvim
```

### License
[MIT](/LICENSE)
