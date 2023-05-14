return {
    {
        'nvim-orgmode/orgmode',
        lazy = true,
        event = "VeryLazy",
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            opts = {
                -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
                highlight = {
                  enable = true,
                  additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
                },
                ensure_installed = {'org'}, -- Or run :TSUpdate org
            },
            config=true,
        },
        init = function()
        end,
        opts = {
            org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
            org_default_notes_file = '~/Dropbox/org/refile.org',
        },
        config = true,
        keys = {
        }
    }
}
