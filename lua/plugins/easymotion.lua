return {
    {
        'easymotion/vim-easymotion',
        lazy = true,
        init = function()
        end,
        opts = {},
        config = function()
        end,
        keys = {
	        {"<leader>l", "<Plug>(easymotion-prefix)", mode = {"n"}},

            -- need input char after this
            {"<Leader>lf", desc = "Find {char} to the right"},
            {"<Leader>lF", desc = "Find {char} to the left"},
            {"<Leader>lt", desc = "Till before the {char} to the right"},
            {"<Leader>lT", desc = "Till after the {char} to the left"},

            {"<Leader>lw", desc = "Beginning of word forward"},
            {"<Leader>lW", desc = "Beginning of WORD forward"},
            {"<Leader>lb", desc = "Beginning of word backward"},
            {"<Leader>lB", desc = "Beginning of WORD backward"},
            {"<Leader>le", desc = "End of word forward"},
            {"<Leader>lE", desc = "End of WORD forward"},
            {"<Leader>lg", desc = "backward"},
            {"<Leader>lge", desc = "End of word backward"},
            {"<Leader>lgE", desc = "End of WORD backward"},
            {"<Leader>lj", desc = "Line downward"},
            {"<Leader>lk", desc = "Line upward"},
            {"<Leader>ln", desc = 'Jump to latest "/" or "?" forward'},
            {"<Leader>lN", desc = 'Jump to latest "/" or "?" backward'},
            {"<Leader>ls", desc = "Find(Search) {char} forward and backward"},
        }
    }
}
