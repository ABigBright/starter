return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>t"] = { name = "+tag" },
        ["<leader>l"] = { name = "+move" },
        ["<leader>h"] = { name = "+help" },
        ["<leader>j"] = { name = "+jump" },
        ["<leader>c"] = { name = "+comment" },
        ["<leader>s"] = { name = "+search/style" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
