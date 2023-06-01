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
    opts = {},
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
    },
  },
}
