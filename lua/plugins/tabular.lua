return {
    {
        'godlygeek/tabular',
        lazy = true,
        init = function()
        end,
        opts = {},
        config = function()
            vim.g.EasyMotion_do_mapping = false
        end,
        keys = {
            {"<leader>si", ":Tabularize /", mode = {"n", "v"}, desc = "indent-with"},
        }
    }
}
