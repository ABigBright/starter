return {
    {
        'rmagatti/auto-session',
        lazy = true,
        event = 'VeryLazy',
        dependencies = {

        },
        init = function()
        end,
        opts = {
            log_level = 'info',
            auto_session_enable_last_session = false,
            -- auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
            auto_session_enabled = true,
            auto_save_enabled = false,
            auto_restore_enabled = false,
        },
        config = true,
        keys = {
            { mode = {"n"}, "<leader>Ss", function() require("auto-session").SaveSession() end, desc = "save-session" }
        }
    }
}
