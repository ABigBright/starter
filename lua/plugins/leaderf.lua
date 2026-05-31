return {
    {
        'Yggdroot/LeaderF',
        lazy = true, -- make sure we load this during startup if it is your main colorscheme
        init = function()
            vim.g.Lf_ShortcutF = '<leader>ff'
            vim.g.Lf_ShortcutB = '<leader>bt'
            -- gtags env vars must be set before LeaderF loads so auto-generate works
            if 1 == vim.fn.has("mac") then
                vim.env.GTAGSCONF="/opt/homebrew/Cellar/global/6.6.14/share/gtags/gtags.conf"
                vim.g.Lf_Gtagsconf="/opt/homebrew/Cellar/global/6.6.14/share/gtags/gtags.conf"
            elseif 1 == vim.fn.has("unix") then
                vim.env.GTAGSCONF="/usr/share/gtags/gtags.conf"
                vim.g.Lf_Gtagsconf="/usr/share/gtags/gtags.conf"
            end
            vim.env.GTAGSLABEL="native-pygments"
            vim.g.Lf_GtagsAutoGenerate = 1
            vim.g.Lf_GtagsAutoUpdate = 1
            vim.g.Lf_Gtagslabel = "native-pygments"
            vim.g.Lf_GtagsSkipUnreadable = 1
            vim.g.Lf_GtagsSource = 2
            vim.g.Lf_GtagsfilesCmd = {
                 git = 'git ls-files --recurse-submodules',
                 hg = 'hg files',
                 default = 'rg --no-messages --files'
                }
        end,
        cmd = {"LeaderfFile"},
        build = "./install.sh",
        config = function(opt)
            vim.g.Lf_StlColorscheme = 'one'
            -- Disable leaderf status line
            -- vim.g.Lf_DisableStl = 1
            vim.g.Lf_StlSeparator = {left= '', right=''}
            vim.g.Lf_WindowHeight = 0.20
            -- vim.g.Lf_WindowPosition = 'top'
            vim.g.Lf_TabpagePosition = 1
            vim.g.Lf_DefaultMode = "NameOnly"
            vim.g.Lf_MaxCount = 0

            -- preview config
            vim.g.Lf_PreviewCode = 1
            vim.g.Lf_PreviewResult = {
                File= 0,
                Buffer= 0,
                Mru= 0,
                Tag= 0,
                BufTag= 1,
                Function= 1,
                Line= 0,
                Colorscheme= 0,
                Rg= 0,
                Gtags= 0
                }

            -- for ctags
            -- vim.g.Lf_Ctags = "/usr/local/universal-ctags/ctags"
            -- vim.g.Lf_CtagsFuncOpts = {
            --         \ 'c': '--c-kinds=fp',
            --         \ 'rust': '--rust-kinds=f',
            --         \ }

            -- for gtags config (moved to init for lazy-load compatibility)

            vim.g.Lf_RootMarkers = {'.root'}
            vim.g.Lf_GtagsGutentags = 0
            vim.g.Lf_WindowPosition = 'bottom'
            vim.g.Lf_PreviewHorizontalPosition = "center"
            vim.g.Lf_PopupShowStatusline = 0
            vim.g.Lf_PopupColorscheme = 'onedark'
            vim.g.Lf_PreviewInPopup = 1
            vim.g.Lf_WorkingDirectoryMode = 'Aac'
            vim.g.Lf_RecurseSubmodules = 1

            -- Show icons, icons are shown by default
            -- vim.g.Lf_ShowDevIcons = 1
            -- For GUI vim, the icon font can be specify like this, for example
            -- vim.g.Lf_DevIconsFont = "Fira Mono for Powerline"
            -- If needs
            -- set ambiwidth=double

            -- vim.g.Lf_PopupPalette = {
            --     \  'light': {
            --     \      'Lf_hl_match': {
            --     \                'gui': 'NONE',
            --     \                'font': 'NONE',
            --     \                'guifg': 'NONE',
            --     \                'guibg': '#303136',
            --     \                'cterm': 'NONE',
            --     \                'ctermfg': 'NONE',
            --     \                'ctermbg': '236'
            --     \      },
            --     \      'Lf_hl_cursorline': {
            --     \                'gui': 'NONE',
            --     \                'font': 'NONE',
            --     \                'guifg': 'NONE',
            --     \                'guibg': '#303136',
            --     \                'cterm': 'NONE',
            --     \                'ctermfg': 'NONE',
            --     \                'ctermbg': '236'
            --     \      },
            --     \  },
            --     \  'dark': {
            --     \      'Lf_hl_match': {
            --     \                'gui': 'NONE',
            --     \                'font': 'NONE',
            --     \                'guifg': 'NONE',
            --     \                'guibg': '#303136',
            --     \                'cterm': 'NONE',
            --     \                'ctermfg': 'NONE',
            --     \                'ctermbg': '236'
            --     \      },
            --     \      'Lf_hl_cursorline': {
            --     \                'gui': 'NONE',
            --     \                'font': 'NONE',
            --     \                'guifg': 'NONE',
            --     \                'guibg': '#303136',
            --     \                'cterm': 'NONE',
            --     \                'ctermfg': 'NONE',
            --     \                'ctermbg': '236'
            --     \      },
            --     \  }
            -- \ }
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"leadref"},
                callback = function()
                    vim.keymap.set('n', "q", ':q!', {silent = true, buffer = true})
                end,
            })
        end,
        keys = {
            {"<leader>ff", desc = "Find file"},
            {"<leader>bt", desc = "Switch buffer"},
            {"<leader>fr", "<cmd>LeaderfMru<cr>", desc = "Recent files"},
            {"<leader>jd", function()
                if require("util").has("noice.nvim") then require("noice").disable() end
                vim.cmd(string.format("Leaderf! gtags -d %s --auto-jump", vim.fn.expand("<cword>")))
            end, silent = true, mode = {"n"}, desc = "Jump to definition"},
            {"<leader>jr", function()
                if require("util").has("noice.nvim") then require("noice").disable() end
                vim.cmd(string.format("Leaderf! gtags -r %s --auto-jump", vim.fn.expand("<cword>")))
            end, silent = true, mode = {"n"}, desc = "Jump to references"},
            {"<leader>js", function()
                if require("util").has("noice.nvim") then require("noice").disable() end
                vim.cmd(string.format("Leaderf! gtags -s %s --auto-jump", vim.fn.expand("<cword>")))
            end, silent = true, mode = {"n"}, desc = "Jump to symbol"},
            {"<leader>je", function()
                if require("util").has("noice.nvim") then require("noice").disable() end
                vim.cmd(string.format("Leaderf! gtags -g %s --auto-jump", vim.fn.expand("<cword>")))
            end, silent = true, mode = {"n"}, desc = "Jump to grep match"},
            {"<leader>jp", function()
                if require("util").has("noice.nvim") then require("noice").disable() end
                vim.cmd("Leaderf gtags --recall")
            end, silent = true, mode = {"n"}, desc = "Recall last jump"},
            {"<leader>jb", function()
                if require("util").has("noice.nvim") then require("noice").disable() end
                vim.cmd("Leaderf gtags --current-buffer --result ctags-mod")
            end, silent = true, mode = {"n"}, desc = "Buffer tags"},
            {"<leader>jB", function()
                if require("util").has("noice.nvim") then require("noice").disable() end
                vim.cmd("Leaderf gtags --all-buffers --result ctags-mod")
            end, silent = true, mode = {"n"}, desc = "All buffer tags"},
            {"<leader>ja", function()
                if require("util").has("noice.nvim") then require("noice").disable() end
                vim.cmd("Leaderf gtags --all --result ctags-mod")
            end, silent = true, mode = {"n"}, desc = "Workspace symbols"},
            {"<leader>sh", ':Leaderf rg -e ', mode = {"n"}, desc = "Rg search"},
            {"<leader>sj", ':Leaderf rg -F -e <c-r><c-w><cr>', mode = {"n"}, desc = "Search word under cursor"},
            {"<leader>sk", ':Leaderf rg -e <c-r><c-w><cr>', mode = {"n"}, desc = "Regex search word"},
            {"<leader>sp", '<cmd>Leaderf rg --recall<cr>', desc = "Recall last search"},
            {"<leader>sl", '<cmd>LeaderfRgInteractive<cr>', desc = "Interactive rg search"},
        }
    },
}
