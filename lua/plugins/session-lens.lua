return {
    {
        'rmagatti/session-lens',
        lazy = true,
        event = 'VeryLazy',
        dependencies = {
            'nvim-telescope/telescope.nvim', 
            tag = '0.1.0',  -- or , { 'branch': '0.1.x' }
        },
        init = function()
        end,
        opts = {
            prompt_title = 'briq sessions',
            path_display = {'shorten'},
            -- theme = 'ivy', -- default is dropdown
            theme_conf = { border = true },
            previewer = false
        },
        config = true,
        keys = {
        }
    }
}
