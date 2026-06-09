return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>em", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {},
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
  },
}
