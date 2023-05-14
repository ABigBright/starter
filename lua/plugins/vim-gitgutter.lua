return {
    {
        'airblade/vim-gitgutter',
        lazy = true,
        event = "VeryLazy",
        init = function()
        end,
        opts = {},
        config = function()
            if vim.fn.has("win32") then
                vim.g.gitgutter_git_executable = 'D:\\PortableGit\\cmd\\git.exe'
            end
        end,
        keys = {
        }
    }
}
