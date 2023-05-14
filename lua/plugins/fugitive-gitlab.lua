return {
    {
        'shumphrey/fugitive-gitlab.vim',
        lazy = true,
        event = "VeryLazy",
        init = function()
        end,
        opts = {},
        config = function()
        -- some example config
        -- vim.g.fugitive_gitlab_domains = { 'http://10.12.3.198/' }
        -- vim.g.gitlab_api_keys = {['http://10.12.3.198/'] = 'AcpJ1xC6HWhzJBzG2xCL'}
        end,
        keys = {
        }
    }
}
