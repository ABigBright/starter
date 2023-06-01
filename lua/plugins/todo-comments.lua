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
        desc = "todo",
        mode = "n",
      },
      {
        "<leader>tsa",
        ":TodoLocList keywords=FIXME,TODO,XXX,HACK cwd=./",
        desc = "todo all search",
        mode = "n",
      },
      {
        "<leader>tsf",
        ":TodoLocList keywords=FIXME cwd=./",
        desc = "fixme search",
        mode = "n",
      },
      {
        "<leader>tst",
        ":TodoLocList keywords=TODO cwd=./",
        desc = "todo search",
        mode = "n",
      },
      {
        "<leader>tsx",
        ":TodoLocList keywords=XXX cwd=./",
        desc = "xxx search",
        mode = "n",
      },
      {
        "<leader>tsh",
        ":TodoLocList keywords=HACK cwd=./",
        desc = "hack search",
        mode = "n",
      },
    },
  },
}
