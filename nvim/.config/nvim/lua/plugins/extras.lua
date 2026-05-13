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
  -- trailing commas, which keeps ktfmt and ktlint in agreement (default
  -- ktfmt uses Google style and strips trailing commas — do not remove this flag).
  -- Function form forces our formatters_by_ft.kotlin pin to win regardless
  -- of opts merge order; ktlint 1.8.0 --stdin --format crashes on '%' chars
  -- so it must NOT be the formatter (it stays in nvim-lint for lint-only).
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.kotlin = { "ktfmt" }

      opts.default_format_opts = vim.tbl_extend(
        "force",
        opts.default_format_opts or {},
        { timeout_ms = 10000 } -- JVM tools cold-start in ~2.5s
      )

      opts.formatters = opts.formatters or {}
      opts.formatters.ktfmt = vim.tbl_extend(
        "force",
        opts.formatters.ktfmt or {},
        { prepend_args = { "--kotlinlang-style" } }
      )

      return opts
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = { enabled = false },
        -- Prefer JetBrains' official Kotlin LSP over fwcd's community one.
        -- NOTE: kotlin_lsp must be installed separately (Mason or manual);
        -- if the binary is missing, nvim-lspconfig will silently skip it.
        kotlin_language_server = { enabled = false },
        kotlin_lsp = {},
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
