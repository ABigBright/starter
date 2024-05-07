return {
  {
    "folke/todo-comments.nvim",
    lazy = true,
    -- event = 'VeryLazy',
    cmd = {
      "TodoTrouble",
      "TodoTelescope",
      "TodoLocList",
      "TodoQuickFix",
    },
    dependencies = {},
    init = function() end,
    opts = {
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        RECD = { icon = " ", color = "info", alt = { "CUS1", "CUS2" } },
      },
    },
    config = true,
    keys = {
      {
        "<leader>ts",
        desc = "todo tag",
        mode = "n",
      },
      {
        "<leader>tsa",
        ":TodoQuickFix keywords=FIXME,TODO,XXX,HACK cwd=./",
        desc = "todo all search",
        mode = "n",
      },
      {
        "<leader>tsf",
        ":TodoQuickFix keywords=FIXME cwd=./",
        desc = "fixme search",
        mode = "n",
      },
      {
        "<leader>tst",
        ":TodoQuickFix keywords=TODO cwd=./",
        desc = "todo search",
        mode = "n",
      },
      {
        "<leader>tsx",
        ":TodoQuickFix keywords=XXX cwd=./",
        desc = "xxx search",
        mode = "n",
      },
      {
        "<leader>tsh",
        ":TodoQuickFix keywords=HACK cwd=./",
        desc = "hack search",
        mode = "n",
      },
      {
        "<leader>tsc",
        ":TodoQuickFix keywords=",
        desc = "cus search with keywords and cwd",
        mode = "n",
      }
    },
  },
}
