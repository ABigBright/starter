return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0", -- or , { 'branch': '0.1.x' }
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    init = function() end,
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
            ["<C-k>"] = "move_selection_previous",
          },
        },
        -- layout_strategy = "horizontal",
        -- layout_config = {
        --   height = 0.8,
        --   preview_cutoff = 120,
        --   prompt_position = "bottom",
        --   width = 0.9,
        -- },
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker

        buffers = {
          layout_strategy = "bottom_pane",
          layout_config = {
            height = 15,
            preview_cutoff = 120,
            -- disable preview
            preview_width = 0,
            prompt_position = "bottom",
          },
        },
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
          find_cmd = "rg", -- find command (defaults to `fd`)
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    },
    config = true,
    keys = {
      { "<leader>bt", "<cmd>Telescope buffers<cr>", desc = "buffer-switch" },
    },
  },
}
