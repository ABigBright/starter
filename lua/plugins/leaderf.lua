return {
{
    'Yggdroot/LeaderF',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
        print("lazy init LeaderF")
    end,
    config = function(opt)
        print("lazy config LeaderF")
        vim.fn.system("./install.sh")
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

	    -- for gtags config
	    if vim.fn.has("mac") then
	        vim.env.GTAGSCONF="/opt/homebrew/Cellar/global/6.6.9/share/gtags/gtags.conf"
	        vim.g.Lf_Gtagsconf="/opt/homebrew/Cellar/global/6.6.9/share/gtags/gtags.conf"
	    elseif vim.fn.has("unix") then
	        vim.env.GTAGSCONF="/usr/share/gtags/gtags.conf"
	        vim.g.Lf_Gtagsconf="/usr/share/gtags/gtags.conf"
	    elseif vim.fn.has("win32") then
	    end

	    vim.env.GTAGSLABEL="native-pygments"
	    vim.g.Lf_GtagsGutentags = 0
	    vim.g.Lf_GtagsAutoUpdate = 1
	    vim.g.Lf_GtagsAutoGenerate = 1
	    vim.g.Lf_Gtagslabel = "native-pygments"
	    vim.g.Lf_RootMarkers = {'.root'}
	    -- vim.g.Lf_WindowPosition = 'popup'
	    -- vim.g.Lf_PreviewHorizontalPosition = "center"
	    -- vim.g.Lf_PreviewInPopup = 1
	    vim.g.Lf_WorkingDirectoryMode = 'Aac'
	    vim.g.Lf_RecurseSubmodules = 1
	    vim.g.Lf_GtagsSkipUnreadable = 1

	    -- Gtags accepts a list of files as target files. This option indicates
	    -- where the target files come from. It has 3 values: 0, 1, 2.
	    -- 0 - gtags search the target files by itself.
	    -- 1 - the target files come from FileExplorer.
	    -- 2 - the target files come from |g.Lf_GtagsfilesCmd|.
	    vim.g.Lf_GtagsSource = 2
	    vim.g.Lf_GtagsfilesCmd = {
	    	 git = 'git ls-files --recurse-submodules',
	    	 hg = 'hg files',
	    	 default = 'rg --no-messages --files'
	    	}

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
    end,
},

}
