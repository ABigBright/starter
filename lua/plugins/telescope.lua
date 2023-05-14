return {
    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.0', -- or , { 'branch': '0.1.x' }
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        init = function()
        end,
        opts = {
            defaults = {
              -- Default configuration for telescope goes here:
              -- config_key = value,
              mappings = {
                i = {
                  -- map actions.which_key to <C-h> (default: <C-/>)
                  -- actions.which_key shows the mappings for your picker,
                  -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                  ["<C-j>"] = "move_selection_next",
                  ["<C-k>"] = "move_selection_previous"
                }
              }
            },
            pickers = {
              -- Default configuration for builtin pickers goes here:
              -- picker_name = {
              --   picker_config_key = value,
              --   ...
              -- }
              -- Now the picker_config_key will be applied every time you call this
              -- builtin picker
            },
            extensions = {
              -- Your extension configuration goes here:
              -- extension_name = {
              --   extension_config_key = value,
              -- }
              -- please take a look at the readme of the extension you want to configure
            }
        },
        config = true,
        keys = {
            { mode = {"n"}, "<leader>Sl", function() require("telescope._extensions.session-lens.main").search_session() end, desc = "load-session" }
        }
    }
}
