return {
    {
        'ABigBright/telekasten.nvim',
        lazy = true,
        branch = 'cus_for_briq',
        -- event = 'VeryLazy',
        dependencies = {
            {
                'nvim-telescope/telescope.nvim', 
                tag = '0.1.0', -- or , { 'branch': '0.1.x' }
            },
            {
                'renerocksai/calendar-vim',
            },
            {
                'nvim-telescope/telescope-media-files.nvim',
                config = function(_, opts)
                    require('telescope').load_extension('media_files')
                end,
            }
        },
        init = function()
        end,
        opts = function(_, opts)
            -- this is customize for briq use only
            local l_filter_extensions = {".org", ".md"}
            vim.g.telekasten_follow_link_filter_extension = l_filter_extensions
            vim.g.telekasten_find_note_filter_extension = l_filter_extensions
            vim.g.telekasten_insert_link_filter_extension = l_filter_extensions
            local home = vim.fn.expand("~/zettelkasten")
            opts = {
                home = home,

                -- if true, telekasten will be enabled when opening a note within the configured home
                take_over_my_home = true,

                -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
                --                               and thus the telekasten syntax will not be loaded either
                auto_set_filetype = true,

                -- dir names for special notes (absolute path or subdir name)
                dailies      = home .. '/' .. 'daily',
                weeklies     = home .. '/' .. 'weekly',
                templates    = home .. '/' .. 'templates',

                -- image (sub)dir for pasting
                -- dir name (absolute path or subdir name)
                -- or nil if pasted images shouldn't go into a special subdir
                image_subdir = "img",

                -- markdown file extension
                extension    = ".md",

                -- Generate note filenames. One of:
                -- "title" (default) - Use title if supplied, uuid otherwise
                -- "uuid" - Use uuid
                -- "uuid-title" - Prefix title by uuid
                -- "title-uuid" - Suffix title with uuid
                new_note_filename = "title",
                -- file uuid type ("rand" or input for os.date()")
                uuid_type = "%Y%m%d%H%M",
                -- UUID separator
                uuid_sep = "-",

                -- following a link to a non-existing note will create it
                follow_creates_nonexisting = true,
                dailies_create_nonexisting = true,
                weeklies_create_nonexisting = true,

                -- skip telescope prompt for goto_today and goto_thisweek
                journal_auto_open = false,

                -- template for new notes (new_note, follow_link)
                -- set to `nil` or do not specify if you do not want a template
                template_new_note = home .. '/' .. 'templates/new_note.md',

                -- template for newly created daily notes (goto_today)
                -- set to `nil` or do not specify if you do not want a template
                template_new_daily = home .. '/' .. 'templates/daily.md',

                -- template for newly created weekly notes (goto_thisweek)
                -- set to `nil` or do not specify if you do not want a template
                template_new_weekly= home .. '/' .. 'templates/weekly.md',

                -- image link style
                -- wiki:     ![[image name]]
                -- markdown: ![](image_subdir/xxxxx.png)
                image_link_style = "markdown",

                -- default sort option: 'filename', 'modified'
                sort = "filename",

                -- integrate with calendar-vim
                plug_into_calendar = true,
                calendar_opts = {
                    -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
                    weeknm = 4,
                    -- use monday as first day of week: 1 .. true, 0 .. false
                    calendar_monday = 1,
                    -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
                    calendar_mark = 'left-fit',
                },

                -- telescope actions behavior
                close_after_yanking = false,
                insert_after_inserting = true,

                -- tag notation: '#tag', ':tag:', 'yaml-bare'
                tag_notation = "#tag",

                -- command palette theme: dropdown (window) or ivy (bottom panel)
                command_palette_theme = "ivy",

                -- tag list theme:
                -- get_cursor: small tag list at cursor; ivy and dropdown like above
                show_tags_theme = "ivy",

                -- when linking to a note in subdir/, create a [[subdir/title]] link
                -- instead of a [[title only]] link
                subdirs_in_links = true,

                -- template_handling
                -- What to do when creating a new note via `new_note()` or `follow_link()`
                -- to a non-existing note
                -- - prefer_new_note: use `new_note` template
                -- - smart: if day or week is detected in title, use daily / weekly templates (default)
                -- - always_ask: always ask before creating a note
                template_handling = "smart",

                -- path handling:
                --   this applies to:
                --     - new_note()
                --     - new_templated_note()
                --     - follow_link() to non-existing note
                --
                --   it does NOT apply to:
                --     - goto_today()
                --     - goto_thisweek()
                --
                --   Valid options:
                --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
                --              all other ones in home, except for notes/with/subdirs/in/title.
                --              (default)
                --
                --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
                --                    except for notes with subdirs/in/title.
                --
                --     - same_as_current: put all new notes in the dir of the current note if
                --                        present or else in home
                --                        except for notes/with/subdirs/in/title.
                new_note_location = "smart",

                -- should all links be updated when a file is renamed
                rename_update_links = true,

                vaults = {
                    vault2 = {
                        -- alternate configuration for vault2 here. Missing values are defaulted to
                        -- default values from telekasten.
                        -- e.g.
                        -- home = "/home/user/vaults/personal",
                    },
                },

                -- how to preview media files
                -- "telescope-media-files" if you have telescope-media-files.nvim installed
                -- "catimg-previewer" if you have catimg installed
                media_previewer = "telescope-media-files",
            }
        end,
        config = function(_, opts)
            require('telekasten').setup(opts)
            vim.cmd([[
                " ----- the following are for syntax-coloring \[\[links\]\] and ==highlighted text==
                " ----- (see the section about coloring in README.md)

                " for gruvbox
                hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
                hi tkBrackets ctermfg=gray guifg=gray

                " real yellow
                hi tkHighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
                " gruvbox
                "hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold

                hi link CalNavi CalRuler
                hi tkTagSep ctermfg=gray guifg=gray
                hi tkTag ctermfg=175 guifg=#d3869B
            ]])
        end,
        keys = {
            { mode = {"n"}, "<leader>zf", function() require('telekasten').find_notes() end, 
                desc = "find-notes", silent = true },
            { mode = {"n"}, "<leader>zd", function() require('telekasten').find_daily_notes() end, 
                desc = "find-daily-notes", silent = true },
            { mode = {"n"}, "<leader>zg", function() require('telekasten').search_notes() end, 
                desc = "search-notes", silent = true },
            { mode = {"n"}, "<leader>zz", function() require('telekasten').follow_link() end, 
                desc = "follow-link", silent = true },
            { mode = {"n"}, "<leader>zT", function() require('telekasten').goto_today() end, 
                desc = "goto-today", silent = true },
            { mode = {"n"}, "<leader>zW", function() require('telekasten').goto_thisweek() end, 
                desc = "goto-thisweek", silent = true },
            { mode = {"n"}, "<leader>zw", function() require('telekasten').find_weekly_notes() end, 
                desc = "find-weekly-notes", silent = true },
            { mode = {"n"}, "<leader>zn", function() require('telekasten').new_note() end, 
                desc = "new-notes", silent = true },
            { mode = {"n"}, "<leader>zN", function() require('telekasten').new_templated_note() end, 
                desc = "new-templated-note", silent = true },
            { mode = {"n"}, "<leader>zy", function() require('telekasten').yank_notelink() end, 
                desc = "yank-notelink", silent = true },
            { mode = {"n"}, "<leader>zc", function() require('telekasten').show_calendar() end, 
                desc = "show-calendar", silent = true },
            { mode = {"n"}, "<leader>zC", "<cmd>CalendarT<cr>", desc = "calendar", silent = true },
            { mode = {"n"}, "<leader>zi", function() require('telekasten').paste_img_and_link() end, 
                desc = "paste-img-and-link", silent = true },
            { mode = {"n"}, "<leader>zt", function() require('telekasten').toggle_todo() end, 
                desc = "toggle-todo", silent = true },
            { mode = {"n"}, "<leader>zb", function() require('telekasten').show_backlinks() end, 
                desc = "show-backlink", silent = true },
            { mode = {"n"}, "<leader>zF", function() require('telekasten').find_friends() end, 
                desc = "find-friends", silent = true },
            { mode = {"n"}, "<leader>zI", function() require('telekasten').insert_img_link({i = true}) end, 
                desc = "insert-img-link", silent = true },
            { mode = {"n"}, "<leader>zp", function() require('telekasten').preview_img() end, 
                desc = "preview-img", silent = true },
            { mode = {"n"}, "<leader>zm", function() require('telekasten').browse_media() end, 
                desc = "browse-media", silent = true },
            { mode = {"n"}, "<leader>za", function() require('telekasten').show_tags() end, 
                desc = "find-daily-notes", silent = true },
            { mode = {"n"}, "<leader>zr", function() require('telekasten').rename_note() end, 
                desc = "rename-notes", silent = true },
            { mode = {"i"}, "<leader>z[", function() require('telekasten').insert_link({i = true}) end, 
                desc = "insert-link", silent = true },
            { mode = {"i"}, "<leader>za", function() require('telekasten').show_tags({i = true}) end, 
                desc = "insert-link", silent = true },
        }
    }
}
