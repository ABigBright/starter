return {
  {
    "rmagatti/auto-session",
    lazy = true,
    event = "VeryLazy",
    dependencies = {},
    init = function() end,
    opts = {
      log_level = "info",
      auto_session_enable_last_session = false,
      -- auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
      auto_session_enabled = true,
      auto_save_enabled = nil,
      auto_restore_enabled = nil,
    },
    config = true,
    keys = {
      {
        mode = { "n" },
        "<leader>Ss",
        function()
          require("auto-session").SaveSession(require("auto-session").get_root_dir(), true)
        end,
        desc = "save session",
      },
      {
        mode = { "n" },
        "<leader>Sl",
        function()
          require('auto-session.session-lens').search_session()
        end,
        desc = "load session",
      },
    },
  },
}
