return {
  {
    "ABigBright/lualine.nvim",
    branch = "cus_for_briq",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")

      return {
        options = {
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {
	    {
	      'windows',
	      show_filename_only = true,   -- Shows shortened relative path when set to false.
	      show_modified_status = true, -- Shows indicator when the window is modified.
	    
	      mode = 1, -- 0: Shows window name
	                -- 1: Shows window index
	                -- 2: Shows window name + window index
							
	      -- show_before = true,
	      -- show_after = true,
	    
	      max_length = vim.o.columns * 2 / 3, -- Maximum width of windows component,
	                                          -- it can also be a function that returns
	                                          -- the value of `max_length` dynamically.
	      filetype_names = {
	        TelescopePrompt = 'Telescope',
	        dashboard = 'Dashboard',
	        packer = 'Packer',
	        fzf = 'FZF',
	        alpha = 'Alpha'
	      }, -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )
	    
	      disabled_buftypes = { 'quickfix', 'prompt' }, -- Hide a window if its buffer's type is disabled
	    
	      -- Automatically updates active window color to match color of other components (will be overidden if buffers_color is set)
	      use_mode_colors = false,
	    
	      windows_color = {
	        -- Same values as the general color option can be used here.
	        -- active = 'lualine_{section}_normal',     -- Color for active window.
	        -- inactive = 'lualine_{section}_inactive', -- Color for inactive window.
	      },
    	    }
          },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
            -- stylua: ignore
            {
              function() return require("nvim-navic").get_location() end,
              cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
            },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = Util.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = Util.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.fg("Debug"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        inactive_sections = {
          lualine_a = {
	    {
	      'windows',
	      show_filename_only = true,   -- Shows shortened relative path when set to false.
	      show_modified_status = true, -- Shows indicator when the window is modified.
	    
	      mode = 2, -- 0: Shows window name
	                -- 1: Shows window index
	                -- 2: Shows window name + window index
	    
	      max_length = vim.o.columns * 2 / 3, -- Maximum width of windows component,
	                                          -- it can also be a function that returns
	                                          -- the value of `max_length` dynamically.
	      filetype_names = {
	        TelescopePrompt = 'Telescope',
	        dashboard = 'Dashboard',
	        packer = 'Packer',
	        fzf = 'FZF',
	        alpha = 'Alpha'
	      }, -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )
	    
	      disabled_buftypes = { 'quickfix', 'prompt' }, -- Hide a window if its buffer's type is disabled
	    
	      -- Automatically updates active window color to match color of other components (will be overidden if buffers_color is set)
	      use_mode_colors = false,
	    
	      windows_color = {
	        -- Same values as the general color option can be used here.
	        -- active = 'lualine_{section}_normal',     -- Color for active window.
	        -- inactive = 'lualine_{section}_inactive', -- Color for inactive window.
	      },
    	    }
          },
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
	-- tabline = {
        --   lualine_a = {},
        --   lualine_b = {'branch'},
        --   lualine_c = {'filename'},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {}
        -- },
	-- winbar = {
	--   lualine_a = {
	--     {
	--       'windows',
	--       show_filename_only = true,   -- Shows shortened relative path when set to false.
	--       show_modified_status = true, -- Shows indicator when the window is modified.
        --
	--       mode = 2, -- 0: Shows window name
	--                 -- 1: Shows window index
	--                 -- 2: Shows window name + window index
        --
	--       max_length = vim.o.columns * 2 / 3, -- Maximum width of windows component,
	--                                           -- it can also be a function that returns
	--                                           -- the value of `max_length` dynamically.
	--       filetype_names = {
	--         TelescopePrompt = 'Telescope',
	--         dashboard = 'Dashboard',
	--         packer = 'Packer',
	--         fzf = 'FZF',
	--         alpha = 'Alpha'
	--       }, -- Shows specific window name for that filetype ( { `filetype` = `window_name`, ... } )
        --
	--       disabled_buftypes = { 'quickfix', 'prompt' }, -- Hide a window if its buffer's type is disabled
        --
	--       -- Automatically updates active window color to match color of other components (will be overidden if buffers_color is set)
	--       use_mode_colors = false,
        --
	--       windows_color = {
	--         -- Same values as the general color option can be used here.
	--         -- active = 'lualine_{section}_normal',     -- Color for active window.
	--         -- inactive = 'lualine_{section}_inactive', -- Color for inactive window.
	--       },
	--         }
        --   },
        --   lualine_b = {},
        --   lualine_c = {'filename'},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = {}
        -- },
	-- inactive_winbar = {},
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
