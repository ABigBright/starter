return {
  {
    'airblade/vim-rooter',
    lazy = true,
    event = "VeryLazy",
    init = function()
    end,
    opts = {
    },
    config = function(_, opts)
      vim.g.rooter_patterns = {'.root', '.git'}
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_resolve_links = 1
    end,
  }
}
