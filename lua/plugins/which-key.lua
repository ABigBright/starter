return {
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>t"] = { name = "+tag/todo" },
        ["<leader>l"] = { name = "+move" },
        ["<leader>h"] = { name = "+help" },
        ["<leader>j"] = { name = "+jump" },
        ["<leader>c"] = { name = "+comment" },
        ["<leader>s"] = { name = "+search/style" },
        ["<leader>e"] = { name = "+lsp" },
        ["<leader>q"] = { name = "+quickfix" },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        -- separator = "⇨", -- symbol used between a key and it's label
        -- separator = "❯", -- symbol used between a key and it's label
        -- separator = "➡", -- symbol used between a key and it's label
        -- separator = "", -- symbol used between a key and it's label
        separator = "󰜴", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
