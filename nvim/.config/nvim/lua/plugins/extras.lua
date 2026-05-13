return {
  -- Language extras
  { import = "lazyvim.plugins.extras.lang.kotlin" },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {},
        kotlin = { "ktlint" },
      },
    },
  },

  -- Override LazyVim kotlin-extra default (ktlint formatter) with ktfmt.
  -- --kotlinlang-style follows JetBrains coding conventions and adds
  -- trailing commas, which keeps ktfmt and ktlint in agreement.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kotlin = { "ktfmt" },
      },
      formatters = {
        ktfmt = {
          prepend_args = { "--kotlinlang-style" },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = { enabled = false },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
