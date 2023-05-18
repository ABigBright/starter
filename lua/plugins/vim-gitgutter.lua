return {
    {
        'airblade/vim-gitgutter',
        lazy = true,
        event = "VeryLazy",
        init = function()
        end,
        opts = {},
        config = function(_, opts)
            if 1 == vim.fn.has("win32") then
                vim.g.gitgutter_git_executable = 'D:\\PortableGit\\cmd\\git.exe'
            end
        end,
        keys = {
        }
    }
}
