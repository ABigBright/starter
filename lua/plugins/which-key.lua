return {
  {
    "folke/which-key.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "helix",
      ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
      --- delay's unit : ms
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,

      notify = true,

      win = {
        wo = {
            winblend = 15,
        },
      },

      defaults = { 
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>b", group = "buffer" },
          { "<leader>c", group = "comment" },
          { "<leader>e", group = "lsp" },
          { "<leader>f", group = "file/find" },
          { "<leader>h", group = "help" },
          { "<leader>j", group = "jump" },
          { "<leader>l", group = "move" },
          { "<leader>q", group = "quickfix" },
          { "<leader>s", group = "search/style" },
          { "<leader>sn", group = "noice" },
          { "<leader>t", group = "tag/todo" },
          { "<leader>w", group = "windows" },
        },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        -- separator = "⇨", -- symbol used between a key and it's label
        -- separator = "❯", -- symbol used between a key and it's label
        separator = "➡", -- symbol used between a key and it's label
        -- separator = "", -- symbol used between a key and it's label
        -- separator = "󰜴", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
        -- set to false to disable all mapping icons,
        -- both those explicitly added in a mapping
        -- and those from rules
        mappings = true,
      },

      -- disable WhichKey for certain buf types and file types.
      disable = {
        ft = {},
        bt = {},
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add(opts.defaults)
    end,
  },
}
