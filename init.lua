-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- options
vim.g.mapleader = " "
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.expandtab      = true
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2
vim.opt.smartindent    = true
vim.opt.ignorecase     = true
vim.opt.smartcase      = true
vim.opt.termguicolors  = true
vim.opt.cursorline     = true
vim.opt.mouse          = "a"
vim.opt.scrolloff      = 8
vim.opt.signcolumn     = "yes"
vim.opt.updatetime     = 250
vim.opt.wrap           = false

-- plugins
require("lazy").setup({

  -- color theme: Neovim's built-in default, no plugin needed

  -- status line (theme follows the active colorscheme)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "auto" },
      })
    end,
  },

  -- syntax highlighting
  -- main branch: requires Neovim 0.12+ and tree-sitter-cli 0.26.1+
  -- (the frozen master branch does not support Neovim 0.12)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- no-op for parsers that are already installed
      require("nvim-treesitter").install({
        "bash", "c", "go", "javascript", "json",
        "lua", "markdown", "python", "swift", "typescript", "yaml",
      })

      -- highlighting and indentation are no longer modules; enable them
      -- per buffer for any filetype that has a parser installed
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if lang and vim.treesitter.query.get(lang, "indents") then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep"  },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers"    },
    },
  },

  -- LSP: mason handles server installation, mason-lspconfig wires them up
  { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed     = { "lua_ls", "pyright", "gopls", "ts_ls" },
      })
    end,
  },

  -- git line-level change indicators
  { "lewis6991/gitsigns.nvim", config = true },

  -- file tree  <leader>e to toggle
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File tree" },
    },
  },
})
