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
          { "<leader>m", group = "markdown" },
          { "<leader>n", group = "noice/notify" },
          { "<leader>o", group = "orgmode" },
          { "<leader>q", group = "quickfix" },
          { "<leader>s", group = "search/style" },
          { "<leader>t", group = "tag/todo" },
          { "<leader>w", group = "windows" },
          { "<leader>z", group = "zettelkasten" },
          { "<leader>S", group = "session" },
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
      -- Fix: lazy.nvim 9.14+ removed Keys.managed, but which-key still
      -- references it at icons.lua:143. Patch it so the lookup returns
      -- nil instead of crashing with "attempt to index field 'managed'".
      local ok, Keys = pcall(require, "lazy.core.handler")
      if ok and Keys and Keys.handlers and Keys.handlers.keys then
        local h = Keys.handlers.keys
        if h.managed == nil then
          h.managed = {}
        end
      end
      local wk = require("which-key")
      wk.setup(opts)
      wk.add(opts.defaults)
    end,
  },
}
