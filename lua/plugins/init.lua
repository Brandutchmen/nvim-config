return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "markdown",
        "markdown_inline",
        "python",
        "go",
        "rust",
        "vue",
        "dockerfile",
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "m4xshen/autoclose.nvim",
    event = "BufEnter",
    config = function()
      require("autoclose").setup()
    end,
  },
  {
    "tzachar/highlight-undo.nvim",
    opts = {
      duration = 300,
      undo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "u",
        map = "undo",
        opts = {},
      },
      redo = {
        hlgroup = "HighlightUndo",
        mode = "n",
        lhs = "<C-r>",
        map = "redo",
        opts = {},
      },
      highlight_for_count = true,
    },
    lazy = false,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup {}
    end,
  },
  {
    "tzachar/local-highlight.nvim",
    config = function()
      require("local-highlight").setup {}
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "folke/twilight.nvim",
    cmd = "Twilight",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "folke/neodev.nvim",
  },
  {
    "laytan/tailwind-sorter.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
    build = "cd formatter && npm ci && npm run build",
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "typescript", "typescriptreact", "javascript", "javascriptreact", "svelte", "vue" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = require "configs.copilot",
    cmd = "Copilot",
    config = function()
      require("copilot").setup()
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require "configs.none-ls"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
          require("tailwindcss-colorizer-cmp").setup {
            color_square_width = 2,
          }
        end,
      },
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 1 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "copilot", group_index = 2 },
        { name = "tailwind", group_index = 2 },
        { name = "nvim_lua", group_index = 3 },
      },
    },
  },
}
