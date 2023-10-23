return {
  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {},
    init = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
    opts = {
      log_level = "info",
      auto_session_enable_last_session = false,
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_session_enabled = true,
      auto_save_enabled = nil,
      auto_restore_enabled = nil,
      auto_session_suppress_dirs = { "~/", "~/zettelkasten/", "~/Downloads/", "/" },
      auto_session_use_git_branch = nil,
      -- the configs below are lua only
      bypass_session_save_file_types = nil,
      session_lens = {
        -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
      -- cwd_change_handling = { -- table: Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
      --   restore_upcoming_session = true, -- boolean: restore session for upcoming cwd on cwd change
      --   pre_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChangedPre` autocmd
      --   post_cwd_changed_hook = nil, -- function: This is called after auto_session code runs for the `DirChanged` autocmd
      -- },
    },
    config = true,
    keys = {
      {
        "<leader>Ss",
        "<cmd>SessionSave<cr>",
        mode = { "n" },
        desc = "save session",
      },
      {
        "<leader>Sl",
        function()
          require("auto-session.session-lens").search_session(nil)
        end,
        mode = { "n" },
        desc = "load session",
      },
    },
  },
}
