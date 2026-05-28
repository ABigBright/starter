return {
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && yarn install',
        lazy = true,
        cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
        init = function()
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 0
            vim.g.mkdp_command_for_global = 0
            vim.g.mkdp_open_to_the_world = 0
            vim.g.mkdp_open_ip = ''
            vim.g.mkdp_browser = ''
            vim.g.mkdp_echo_preview_url = 0
            vim.g.mkdp_browserfunc = ''
            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                maid = {},
                disable_sync_scroll = 0,
                sync_scroll_type = 'middle',
                hide_yaml_meta = 1,
                sequence_diagrams = {},
                flowchart_diagrams = {}
            }
            vim.g.mkdp_markdown_css = ''
            vim.g.mkdp_highlight_css = ''
            vim.g.mkdp_port = ''
            vim.g.mkdp_page_title = '「${name}」'
            vim.g.mkdp_filetypes = { 'markdown', 'telekasten' }
        end,
        ft = { 'markdown', 'telekasten' },
        keys = {
            { mode = {"i"}, "<leader>m", desc = "which_key_ignore" },
            { mode = {"n", "i"}, "<leader>mp", "<Plug>MarkdownPreview",
                desc = "markdown-preview", remap = true },
            { mode = {"n", "i"}, "<leader>ms", "<Plug>MarkdownPreviewStop",
                desc = "markdown-preview-stop", remap = true },
            { mode = {"n", "i"}, "<leader>mt", "<Plug>MarkdownPreviewToggle",
                desc = "markdown-preview-toggle", remap = true }
        }
    }
}
