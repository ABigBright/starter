return {
  -- noicer ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- which key integration
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          if require("util").has("noice.nvim") then
            if opts.defaults then
              opts.defaults["<leader>sn"] = { name = "+noice" }
            else
              opts.defaults = {
                ["<leader>sn"] = { name = "+noice" },
              }
            end
          end
        end,
      },
    },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        opts = {},
        ---@type table<string, CmdlineFormat>
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%slua%s+", "^:%slua%s=%s", "^:%s=%s" }, icon = "", lang = "lua" },
          help = { pattern = "^:%she?l?p?%s+", icon = "" },
          input = {},
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
      messages = {
        enabled = true,
      },
      popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "nui", -- backend to use to show regular cmdline completions
        ---@type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
      -- LeaderF uses popup windows with its own input prompt. Noice's
      -- cmdline_popup and message popups steal focus from LeaderF's input
      -- window, causing cursor loss and keystrokes going to noice instead.
      -- Temporarily disable noice when entering LeaderF, re-enable on exit.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "leaderf",
        callback = function()
          require("noice").disable()
        end,
      })
      vim.api.nvim_create_autocmd("BufLeave", {
        callback = function()
          if vim.bo.filetype == "leaderf" then
            vim.schedule(function()
              require("noice").enable()
            end)
          end
        end,
      })
    end,
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
  },
}
