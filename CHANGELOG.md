# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Rewrite README with comprehensive documentation: prerequisites, installation guide, directory structure, functional descriptions for each plugin, complete keybindings reference, Vim options summary, and plugin management tips
- Fix markdown-preview first invocation not working by moving `vim.g.mkdp_*` config from `config()` to `init()`, adding `cmd` and `ft` lazy-load triggers
- Enable noice cmdline_popup and messages (both were previously disabled for LeaderF compatibility)

### Changed
- Noice cmdline format icons updated to nerd font icons (command, search, lua, help, input, filter)
- Search and command input now use popup view instead of bottom bar (`bottom_search = false`, `command_palette = false`)

### Fixed
- Resolve noice and LeaderF conflict: temporarily disable noice when LeaderF popup is active (FileType leaderf -> noice.disable), re-enable on BufLeave so all noice features work outside LeaderF
- LeaderF gtags not auto-generating: move gtags config variables (GTAGSCONF, GTAGSLABEL, Lf_GtagsAutoGenerate, etc.) from `config()` to `init()` so they are set before lazy-load triggers
- Fix GTAGSCONF path from global 6.6.9 to 6.6.14
- Fix which-key crash on leader key press: patch `Keys.managed` nil error caused by lazy.nvim 9.14+ removing the `managed` field from its keys handler API
- Fix orgmode treesitter `inline_code_block` query error: use orgmode's own grammar installer (`:Org install_treesitter_grammar`) instead of deprecated `setup_ts_grammar()`, re-enable 'org' in treesitter ensure_installed
- Fix LeaderF gtags error window focus loss: convert gtags keymaps from printf command strings to Lua functions that disable noice before calling LeaderF, preventing noice cmdline_popup from stealing focus
- Fix neo-tree migration warnings: replace `vim.loop` with `vim.uv` (deprecated in Neovim 0.10+), convert `follow_current_file` from boolean to table format (`{ enabled = true }`), use canonical `command.execute({ action = "close" })` instead of `close_all()`, remove obsolete `neo_tree_remove_legacy_commands`
- Fix `vim.lsp.get_active_clients()` deprecation warning: replace with `vim.lsp.get_clients()` in util/init.lua
- Replace all remaining `vim.loop` calls with `vim.uv` across config (util/init.lua, lazy.lua, orgmode.lua)
- Add `<leader>nd` (noice disable) and `<leader>ne` (noice enable) toggle commands for manual noice control
- Move noice sub-menu from `<leader>sn` to `<leader>n` (nl/nh/na/nd/ne) and notify dismiss from `<leader>un` to `<leader>nn`
- Add which-key groups: `<leader>m` (markdown), `<leader>o` (orgmode), `<leader>z` (zettelkasten), `<leader>S` (session), `<leader>n` (noice/notify)
- Add human-readable which-key descriptions across all keymaps (keymaps.lua, leaderf.lua, fzf.lua, telekasten.lua, todo-comments.lua, vista.lua, markdown-preview.lua, tabular.lua, easymotion.lua, luasnip.lua, noice.lua, which-key.lua)
- Update README.md keybindings reference to reflect `<leader>n` group, `<leader>nn` notify dismiss, and new which-key groups (m/o/S/z)

## [0.3.0] - 2025-09-27

### Added
- Add necessary comments in config files
- Telescope plugin not specified tag version, use latest commit instead

### Fixed
- Fix open saved session error in auto-session

## [0.2.0] - 2025-09-25

### Changed
- Adjust some plugin compatibility after update nvim to v0.11.4
- Remove lazy-lock.json from repo, update .gitignore to exclude it

### Removed
- Remove unused code block
- Remove unused options

### Fixed
- Fix orgmode error, strip org support in treesitter

## [0.1.0] - 2025-09-24

### Changed
- Start strip LazyVim repo dependency, use `config/init/init.lua` and `util/init.lua` instead of LazyVim's default config module
- Add init dir for custom bootstrap logic

### Fixed
- Fix asm error with ctags in vista.vim

## Pre-release History

### Core Plugins Setup

- Add leaderf plugin, some options, build a fork LazyVim for customization
- Add the missing config for leaderf plugin
- Add neo-tree plugin with auto-expand width and auto-close on file open
- Add which-key plugin, fix leaderf shortkey
- Add nvim-treesitter and vista plugin
- Add lualine, nerdcommenter, noice, vim-rooter plugin
- Add tabular, easymotion and default vim options
- Add fugitive-gitlab, fzf, fugitive, gitgutter, rhubarb, vim-surround plugin
- Add keymaps for fzf, add which-key group name
- Add coc lsp plugin (later removed)
- Add auto-session/session-lens/orgmode/telescope/vim-visual-multi plugin
- Add orgmode plugin and support for org in treesitter
- Add todo-comment plugin, adjust keymap and autocmd
- Add telekasten, telescope-media-files plugin
- Add markdown-preview plugin
- Add nvim-cmp plugin with keymap
- Add luasnip plugin
- Add nvim-bqf plugin
- Add nvim-spectre plugin
- Add vim-notify, dressing plugin
- Add vim-markdown-toc plugin for generating TOC
- Add venn.nvim ASCII diagram plugin (later disabled)
- Add graph-easy for dot to ASCII (later removed)
- Add CUS1, CUS2 custom tag for todo-comments

### Keymaps

- Add misc keymap, adjust leaderf about OS detect
- Add window manipulate keymap and close neo-tree window on file open
- Add window operate keymap (resize, split, switch by number)
- Add keymap for quickfix open/close
- Add keymaps for leaderf rg search
- Add keymaps for nvim-cmp (Tab/S-Tab/C-Space/CR)
- Add keymaps for fzf (Files, GFiles, Rg, Ag, Buffers, Maps, Commands, History)
- Add keymaps for markdown-preview (start/stop/toggle)
- Add keymaps for todo-comments search (FIXME/TODO/XXX/HACK/custom)
- Add keymaps for telekasten (find/search/follow/calendar/daily/weekly/tags/backlinks)
- Add session-name and function under cursor display to lualine
- Add suppressed paths in auto-session (home, zettelkasten, Downloads)

### Fixes

- Fix not specify branch cus_for_briq for LazyVim
- Fix gitgutter not show in sign column
- Fix auto-session not auto save
- Fix auto-session bug in lazyload mode, set it not lazy
- Fix cancel insert mode keymap prompt, add markdown preview support for telekasten filetype
- Fix leaderf forced to use popup window because input has conflict with noice plugin
- Fix add root marker for leaderf auto generate gtags
- Fix Error detected while processing TextChangedI Autocomnd for nvim-cmp issue #1310
- Fix fzf bin not properly install problem
- Fix telekasten keymap description error
- Fix vista asm error with ctags
- Fix open saved session error
- Fix markdown-preview first invocation not working

### Refactors

- Adjust code format, temp remove coc, use nvim-lsp instead
- Disable noice message for compatibility with leaderf find file
- Refactor nvim-cmp keymap
- Refactor todo-comments keymap
- Modify which-key separator between key and key label
- Add fzf sorter for telescope
- Revert telescope buffer switch, use leaderf buffer with regex mode instead
- Disable cmdline noice UI temporarily because cooperated with leaderf rg has cursor lost problem
- Modify venn.nvim config
- Remove keymaps for graph-easy
- Remove ascii and vim-boxdraw plugins
- Disable ASCII diagram plugin venn
- Remove unused options
- Remove unused code block