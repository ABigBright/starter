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
        ["<leader>bt"] = { "leaderf-buffer" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>ff"] = { "leaderf-file" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>t"] = { name = "+tag" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
