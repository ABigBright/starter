return {
    {
        'scrooloose/nerdcommenter',
        lazy = true, -- make sure we load this during startup if it is your main colorscheme
        event = 'VeryLazy',
        init = function()
        end,
        cmd = {},
        config = function(opt)
            -- Add spaces after comment delimiters by default
            vim.g.NERDSpaceDelims = 1

            -- Use compact syntax for prettified multi-line comments
            vim.g.NERDCompactSexyComs = 1

            -- Align line-wise comment delimiters flush left instead of following code indentation
            vim.g.NERDDefaultAlign = 'left'

            -- Set a language to use its alternate delimiters by default
            vim.g.NERDAltDelims_java = 1

            -- Add your own custom formats or override the defaults
            vim.g.NERDCustomDelimiters = {
                c = {
                    ['left'] = '/*',
                    ['right'] = '*/',
                },
                cpp = {
                    ['left'] = '/*', 
                    ['right'] = '*/',
                }
            }

            -- Allow commenting and inverting empty lines (useful when commenting a region)
            vim.g.NERDCommentEmptyLines = 1

            -- Enable trimming of trailing whitespace when uncommenting
            vim.g.NERDTrimTrailingWhitespace = 1

            -- Enable NERDCommenterToggle to check all selected lines is commented or not 
            vim.g.NERDToggleCheckAllLines = 1
        end,
        keys = {
            -- example: {"<leader>sh", '<Plug>LeaderfRgPrompt', mode = {"n"}, desc = "toggole-leaderf-search"},
        }
    },
}
