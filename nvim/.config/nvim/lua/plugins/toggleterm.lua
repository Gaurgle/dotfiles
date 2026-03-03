return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = {
      direction = "horizontal",
      hide_numbers = true,
      start_in_insert = true,
      close_on_exit = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
      -- Set mapping after plugin is loaded
      vim.keymap.set({ "n", "t" }, "<C-/>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
      vim.keymap.set({ "n", "t" }, "<C-_>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
    end,
  },
}
