return {
  {
    "gsass1/ascii.nvim",
    version = false, -- last release is way too old and doesn't work on Windows
    lazy = true,
    event = "VeryLazy",
    -- event = { "BufReadPost", "BufNewFile" },
    cmd = "Box",
    dependencies = {},
    keys = {
      { "<leader>gb", "<cmd>Box<cr>", mode = { "v" }, desc = "surround box" },
    },
    config = function(_, opts)
      vim.g.ascii_default_hpadding = 1
      vim.g.ascii_default_vpadding = 1
      vim.g.ascii_hline_char = "-"
      vim.g.ascii_vline_char = "|"
      vim.g.ascii_corner_char = "+"
    end,
  },
}
