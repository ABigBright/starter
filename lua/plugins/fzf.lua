return {
    {
        'junegunn/fzf.vim',
        dependencies = {
            'junegunn/fzf', 
            dir = '~/.fzf',
            build = { './install --all' }
        },
        lazy = true,
        cmd = {"Files", "Rg", "Ag", "GFiles", "Buffers"},
        init = function()
        end,
        opts = {},
        config = function()
            -- This is the default extra key bindings
            -- vim.g.fzf_action = {
            --   \ 'ctrl-t': 'tab split',
            --   \ 'ctrl-x': 'split',
            --   \ 'ctrl-v': 'vsplit' }

            -- An action can be a reference to a function that processes selected lines
            -- function! s:build_quickfix_list(lines)
            --   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
            --   copen
            --   cc
            -- endfunction

            -- vim.g.fzf_action = {
            --   \ 'ctrl-q': function('s:build_quickfix_list'),
            --   \ 'ctrl-t': 'tab split',
            --   \ 'ctrl-x': 'split',
            --   \ 'ctrl-v': 'vsplit' }

            -- Default fzf layout
            -- - down / up / left / right / window
            -- vim.g.fzf_layout = { 'down': '40%' }
            vim.g.fzf_layout = { window = { ['width'] = 0.9, ['height'] = 0.8 } }

            -- You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
            -- vim.g.fzf_layout = { 'window': 'enew' }
            -- vim.g.fzf_layout = { 'window': '-tabnew' }
            -- vim.g.fzf_layout = { 'window': '10new' }

            -- Customize fzf colors to match your color scheme
            -- - fzf#wrap translates this to a set of `--color` options
            vim.g.fzf_colors = { 
              ['fg'] = { 'fg', 'Normal' },
              ['bg'] = { 'bg', 'Normal' },
              ['hl'] = { 'fg', 'Comment' },
              ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
              ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
              ['hl+'] = { 'fg', 'Statement' },
              ['info'] = { 'fg', 'PreProc' },
              ['border'] = { 'fg', 'Ignore' },
              ['prompt'] = { 'fg', 'Conditional' },
              ['pointer'] = { 'fg', 'Exception' },
              ['marker'] = { 'fg', 'Keyword' },
              ['spinner'] = { 'fg', 'Label' },
              ['header'] = { 'fg', 'Comment' }
            }

            -- Enable per-command history
            -- - History files will be stored in the specified directory
            -- - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
            --   'previous-history' instead of 'down' and 'up'.
            -- vim.g.fzf_history_dir = '~/.local/share/fzf-history'


            -- When fzf starts in a terminal buffer, the file type of the buffer is set to fzf. 
            -- So you can set up FileType fzf autocmd to customize the settings of the window.

            -- For example, if you use a non-popup layout (e.g. {'down': '40%'}) on Neovim, 
            -- you might want to temporarily disable the statusline for a cleaner look.
            -- if has('nvim') && !exists('g:fzf_layout')
            --   autocmd! FileType fzf
            --   autocmd  FileType fzf set laststatus=0 noshowmode noruler
            --     \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
            -- endif

            -- for :Files config
            vim.g.fzf_files_options = { '--bind', 'ctrl-n:preview-page-down,ctrl-p:preview-page-up' }
        end,
        keys = {
            { "<leader>fF", "<cmd>Files<cr>", mode = {"n"}, desc = "fzf-files" },
            { "<leader>fg", "<cmd>GFiles<cr>", mode = {"n"}, desc = "git-files" },
            { "<leader>fG", "<cmd>GFiles?<cr>", mode = {"n"}, desc = "git-modified-files" },
            { "<leader>sg", ":Rg ", mode = {"n"}, desc = "rg-search-workspace" },
            { "<leader>sm", ":Ag ", mode = {"n"}, desc = "ag-search-workspace" },
            { "<leader>bf", "<cmd>Buffers<cr> ", mode = {"n"}, desc = "buffers" },
            { "<leader>hA", "<cmd>Maps<cr> ", mode = {"n"}, desc = "keymaps" },
            { "<leader>hB", "<cmd>Commands<cr> ", mode = {"n"}, desc = "commands" },
            { "<leader>hf", "<cmd>History:<cr> ", mode = {"n"}, desc = "file-history" },
            { "<leader>hs", "<cmd>History/<cr> ", mode = {"n"}, desc = "search-history" },
            { "<leader>ht", "<cmd>Helptags<cr> ", mode = {"n"}, desc = "help-tags" },
            { "<leader>hu", "<cmd>Filetypes<cr> ", mode = {"n"}, desc = "filetypes" },
            { "<leader>jm", "<cmd>Marks<cr> ", mode = {"n"}, desc = "all-marks" },
        }
    }
}
