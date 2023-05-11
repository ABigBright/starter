return {
    {
        'liuchengxu/vista.vim',
        lazy = true,
        init = function(plug)
        end,
        cmd = {'Vista', 'VistaToggle'},
        opts = {
            vista_where_func = function()
                local str = ''
                if (vim.b.vista_nearest_method_or_function) then
                    str = vim.b.vista_nearest_method_or_function
                end
                return str
            end,
        },
        config = function(plug, opts)
            -- inline vimscript in lua
            local result = vim.api.nvim_exec(
            [[
            function! NearestMethodOrFunction() abort
              return get(b:, 'vista_nearest_method_or_function', '')
            endfunction
            set statusline+=%{NearestMethodOrFunction()}
            ]],
            true)

            -- By default vista.vim never run if you don't call it explicitly.
            --
            -- If you want to show the nearest function in your statusline automatically,
            -- you can add the following line to your vimrc 

            vim.api.nvim_create_autocmd({"VimEnter"}, {
                pattern = {"*"},
                callback = function(ev)
                    vim.fn['vista#RunForNearestMethodOrFunction']()
                end
            })

            -- How each level is indented and what to prepend.
            -- This could make the display more compact or more spacious.
            -- e.g., more compact: ["▸ ", ""]
            -- Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
            vim.g.vista_icon_indent = { "╰─▸ ", "├─▸ " }

            -- Executive used when opening vista sidebar without specifying it.
            -- See all the avaliable executives via `:echo g:vista#executives`.
            vim.g.vista_default_executive = 'ctags'

            if 1 == vim.fn.has("mac") then
                vim.g.vista_ctags_executable = '/opt/homebrew/bin/ctags'
            end
            -- Set the executive for some filetypes explicitly. Use the explicit executive
            -- instead of the default one for these filetypes when using `:Vista` without
            -- specifying the executive.
            -- let g:vista_executive_for = {
            --   \ 'cpp': 'vim_lsp',
            --   \ 'php': 'vim_lsp',
            --   \ }
            vim.g.vista_executive_for = {
                sh = 'coc',
                py = 'coc',
                js = 'coc',
                ts = 'coc',
            }

            -- Declare the command including the executable and options used to generate ctags output
            -- for some certain filetypes.The file path will be appened to your custom command.
            -- For example:
            -- let g:vista_ctags_cmd = {
            --       \ 'haskell': 'hasktags -x -o - -c',
            --       \ }

            -- To enable fzf's preview window set g:vista_fzf_preview.
            -- The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
            -- For example:
            vim.g.vista_fzf_preview = { 'right:50%' }
            -- Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
            -- let g:vista#renderer#enable_icon = 1

            -- The default icons can't be suitable for all the filetypes, you can extend it as you wish.
            vim.g['vista#renderer#icons']['function'] = " "
            vim.g['vista#renderer#icons']['variable'] = ""

            vim.g.vista_fold_toggle_icons = { "╰─▸ ", "├─▸ " }

            vim.g.vista_update_on_text_changed = 1
            vim.g.vista_close_on_jump = 1
            vim.g.vista_disable_statusline = 1

            -- vim.g['vista#renderer#icons'] = {
            --     default = "",
            -- }
        end,
        keys = {
            {
                "<leader>tt", 
                function() 
                    vim.g.vista_stay_on_open = 1 
                    vim.fn['vista#sidebar#Toggle']()
                end, 
                mode = {"n", "v"}, 
                desc = "tag-list"
            },
            {
                "<leader>tp", 
                function() 
                    vim.g.vista_stay_on_open = 0 
                    vim.fn['vista#sidebar#Toggle']()
                end, 
                mode = {"n", "v"}, 
                desc = "tag-preview"
            },
            {
                "<leader>tc", 
                "<cmd>Vista coc<cr>",
                mode = {"n", "v"}, 
                desc = "tag-preview"
            },
        },
    }
}


