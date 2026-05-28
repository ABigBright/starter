# Neovim Config

Personal Neovim configuration based on lazy.nvim plugin manager, originally forked from LazyVim but heavily customized. LazyVim's default plugin set has been stripped out -- only the utility layer (`config.init`) is retained, and all plugins are individually configured in `lua/plugins/`.

The goal: a batteries-included Neovim setup for daily development, note-taking (Zettelkasten + Orgmode), and code navigation (LeaderF + gtags), with clear keybindings that a new user can follow step by step.

## Prerequisites

| Dependency | Why | Install (macOS) |
|---|---|---|
| Neovim >= 0.9 | Required by lazy.nvim and many plugins | `brew install neovim` |
| Git | lazy.nvim bootstrap + fugitive/rhubarb | Already on macOS |
| A Nerd Font | Icons in lualine, neo-tree, which-key, etc. | `brew install --cask font-fira-mono-nerd-font` (or any Nerd Font) |
| Node.js / yarn | markdown-preview.nvim build step | `brew install node yarn` |
| ctags (universal-ctags) | vista.vim symbol navigation | `brew install universal-ctags` |
| global (gtags) | LeaderF gtags integration | `brew install global` |
| rg (ripgrep) | LeaderF rg search, telescope, fzf | `brew install ripgrep` |
| ag (silver-searcher) | fzf Ag search | `brew install silver-searcher` |
| Python 3 | LeaderF C extension | `brew install python` |
| fzf binary | fzf.vim dependency | `brew install fzf` |

Optional but recommended:

| Dependency | Why |
|---|---|
| terminal-notifier | macOS notifications for orgmode |

## Installation

1. **Backup your existing config** (if any):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **Clone this repo**:

   ```bash
   git clone https://github.com/ABigBright/starter ~/.config/nvim
   ```

3. **Start Neovim** -- lazy.nvim will bootstrap itself and install all plugins on first launch:

   ```bash
   nvim
   ```

   Wait for the installation to complete. You may see notifications about plugin builds (markdown-preview, LeaderF, fzf, telescope-fzf-native). Restart Neovim once everything finishes.

4. **Verify** -- press `<Space>` (your leader key) and wait 200ms; which-key will pop up showing all available groups.

## Directory Structure

```
~/.config/nvim/
  init.lua                        -- Entry point, loads config.init.lazy
  stylua.toml                     -- Lua formatter settings
  lua/
    config/
      init.lua                    -- NOT the bootstrap; this is the LazyVim utility module (colorscheme, icons, setup logic)
      init/
        init.lua                  -- Calls config.init.init() then config.init.setup()
        lazy.lua                  -- lazy.nvim bootstrap + plugin spec loading
      keymaps.lua                 -- Custom keybindings
      options.lua                 -- Vim options (leader, numbers, encoding, etc.)
      autocmds.lua                -- Custom autocmds
      misc.lua                    -- Transparency toggle helper
    plugins/                      -- One file per plugin, each returns a lazy.nvim spec
      auto-session.lua
      dressing.lua
      easymotion.lua
      fzf.lua
      leaderf.lua
      lualine.lua
      luasnip.lua
      markdown-preview.lua
      neo-tree.lua
      nerdcommenter.lua
      noice.lua
      nvim-bqf.lua
      nvim-cmp.lua
      nvim-notify.lua
      nvim-spectre.lua
      orgmode.lua
      tabular.lua
      telekasten.lua
      telescope.lua
      todo-comments.lua
      treesitter.lua
      venn.lua
      vim-fugitive.lua
      vim-gitgutter.lua
      vim-markdown-toc.lua
      vim-rhubarb.lua
      vim-rooter.lua
      vim-surround.lua
      vim-visual-multi.lua
      vista.lua
      which-key.lua
      ...
    trigger/                      -- Core plugin specs loaded before user plugins
      core.lua                    -- lazy.nvim version pin + config.init bootstrap
      colorscheme.lua             -- tokyonight, catppuccin, monokai-pro
    util/
      init.lua                    -- Utility functions (has, fg, get_root, telescope, float_term, toggle, lazy_notify)
```

## Leader Key

The leader key is **Space** (`vim.g.mapleader = " "`).

All keybindings below use `<leader>` to mean Space. Press Space and wait ~200ms -- which-key will display available groups.

## Keybindings Reference

### General

| Key | Mode | Action |
|---|---|---|
| `S` | n | Save file (`:w!`) |
| `Q` | n | Quit (`:q!`) |
| `R` | n | Reload config (`:source $MYVIMRC`) |
| `n` | n | Next search result (centered: `nzz`) |
| `N` | n | Previous search result (centered: `Nzz`) |
| `<leader><CR>` | n | Clear search highlight |
| `q` | n | Quit (in help/quickfix windows only) |

### Window Management

| Key | Mode | Action |
|---|---|---|
| `<C-j>` | n | Resize window height +5 |
| `<C-k>` | n | Resize window height -5 |
| `<M-j>` | n | Resize window width -5 |
| `<M-k>` | n | Resize window width +5 |
| `<leader>1`-`<leader>9` | n | Switch to window 1-9 |
| `<leader>d1`-`<leader>d9` | n | Quit window 1-9 |
| `<leader>wr` | n | Split window to the right |
| `<leader>wl` | n | Split window to the left |
| `<leader>wb` | n | Split window below |
| `<leader>wu` | n | Split window above |
| `<leader>wo` | n | Close all windows except current |
| `<leader>wh` | n | Toggle horizontal/vertical split layout |
| `<leader>wv` | n | Toggle vertical/horizontal split layout |
| `<leader>wp` | n | Go to previous window |

### Quickfix

| Key | Mode | Action |
|---|---|---|
| `<leader>qo` | n | Open quickfix list (height 10) |
| `<leader>qc` | n | Close quickfix list |

### Help / Config Access

| Key | Mode | Action |
|---|---|---|
| `<leader>hi` | n | Open lazy.lua config file |
| `<leader>hp` | n | Open plugins directory in neo-tree |
| `<leader>hk` | n | Open keymaps.lua |
| `<leader>hP` | n | Open installed plugins directory in neo-tree |
| `<leader>hl` | n | Open Lazy plugin manager UI |

## Plugin Keybindings

### Neo-tree

> Neo-tree is a Neovim filesystem browser that lets you visually navigate your project directory, open files, create/delete/rename files and directories, all from a sidebar panel. It supports following the current file and auto-closing on file open.

| Key | Mode | Action |
|---|---|---|
| `<leader>fc` | n | Open neo-tree at project root |
| `<leader>ft` | n | Open neo-tree at cwd |

Inside neo-tree, `<Space>` is unmapped (so it doesn't interfere with leader). Files auto-close neo-tree on open.

### LeaderF

> LeaderF is an efficient fuzzy finder that helps locate files, buffers, MRUs, gtags, etc. on the fly. It supports multiple search modes (NameOnly, Fuzzy, Regex) and integrates with GNU Global (gtags) for definition/reference/symbol jumping. It also provides rg/ag full-text search with live preview.

| Key | Mode | Action |
|---|---|---|
| `<leader>ff` | n | Find files |
| `<leader>bt` | n | Switch buffer (regex mode) |
| `<leader>fr` | n | Recent files (MRU) |
| `<leader>jd` | n | Jump to definition (gtags) |
| `<leader>jr` | n | Jump to references (gtags) |
| `<leader>js` | n | Jump to symbol (gtags) |
| `<leader>je` | n | Jump to egrep pattern (gtags) |
| `<leader>jp` | n | Previous gtags jump results |
| `<leader>jb` | n | Current buffer tags |
| `<leader>jB` | n | All buffer tags |
| `<leader>ja` | n | All symbols in workspace |
| `<leader>sh` | n | LeaderF rg search (type pattern after) |
| `<leader>sj` | n | rg search word under cursor (exact) |
| `<leader>sk` | n | rg regex search word under cursor |
| `<leader>sp` | n | Recall last search results |
| `<leader>sl` | n | Interactive rg search |

LeaderF uses popup window mode with preview. Press `<Tab>` to switch between search and preview. In LeaderF prompt windows, press `q` to quit.

### FZF

> fzf.vim is a Vim plugin wrapping the fzf command-line fuzzy finder. It provides commands like `:Files`, `:GFiles`, `:Rg`, `:Buffers`, `:Marks`, `:History`, `:Helptags`, etc. for quickly finding files, searching text, switching buffers, and browsing command/search history -- all with a floating window UI.

| Key | Mode | Action |
|---|---|---|
| `<leader>fF` | n | Find files (fzf) |
| `<leader>fg` | n | Git files |
| `<leader>fG` | n | Git modified files (`:GFiles?`) |
| `<leader>sg` | n | rg search workspace |
| `<leader>sm` | n | ag search workspace |
| `<leader>bf` | n | Buffer list |
| `<leader>hA` | n | All keymaps |
| `<leader>hB` | n | All commands |
| `<leader>hf` | n | Command history |
| `<leader>hs` | n | Search history |
| `<leader>ht` | n | Help tags |
| `<leader>hu` | n | Filetypes |
| `<leader>jm` | n | Marks |

### Easymotion

> Vim Easymotion provides "Vim motions on speed!" -- it lets you jump to any position in the visible buffer with minimal keystrokes. Type a trigger key followed by a target character, and easymotion highlights all matches with jump labels, so you can reach any visible location in 2-3 keystrokes.

All easymotion keys use `<leader>l` as prefix (the easymotion prefix `<Plug>(easymotion-prefix)`).

| Key | Mode | Action |
|---|---|---|
| `<leader>lf` | n | Find {char} to the right |
| `<leader>lF` | n | Find {char} to the left |
| `<leader>lt` | n | Till before {char} right |
| `<leader>lT` | n | Till after {char} left |
| `<leader>lw` | n | Jump to start of word forward |
| `<leader>lW` | n | Jump to start of WORD forward |
| `<leader>lb` | n | Jump to start of word backward |
| `<leader>lB` | n | Jump to start of WORD backward |
| `<leader>le` | n | Jump to end of word forward |
| `<leader>lE` | n | Jump to end of WORD forward |
| `<leader>lg` | n | Jump backward (any direction) |
| `<leader>lge` | n | End of word backward |
| `<leader>lgE` | n | End of WORD backward |
| `<leader>lj` | n | Jump line downward |
| `<leader>lk` | n | Jump line upward |
| `<leader>ln` | n | Jump to latest `/` or `?` forward |
| `<leader>lN` | n | Jump to latest `/` or `?` backward |
| `<leader>ls` | n | Search {char} forward and backward |

After pressing the prefix, type the target character. Easymotion highlights all matches and assigns jump labels.

### Vista

> Vista.vim provides a sidebar to view and search LSP symbols and ctags in the current file. It shows the function/class/variable outline hierarchy, lets you quickly jump to any symbol, and feeds the nearest function name into the statusline so you always know which function your cursor is inside.

| Key | Mode | Action |
|---|---|---|
| `<leader>tt` | n/v | Toggle vista sidebar (stay in current window) |
| `<leader>tp` | n/v | Toggle vista sidebar (jump to tag on select) |

Vista's default executive is ctags (configured to use `/opt/homebrew/bin/ctags` on macOS). Vista also feeds `vim.b.vista_nearest_method_or_function` into the lualine statusline so you can see which function your cursor is inside.

### Noice

> Noice is a highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu. It provides a modern, stylized interface for Neovim's built-in messages, command-line input, LSP hover docs, and search -- with scrollable popups, history browsing, and redirect capabilities. Both cmdline_popup and messages are enabled, using popup views for command input and search.

| Key | Mode | Action |
|---|---|---|
| `<S-Enter>` | c | Redirect current cmdline command |
| `<leader>snl` | n | Show last noice message |
| `<leader>snh` | n | Show noice message history |
| `<leader>sna` | n | Show all noice messages |
| `<leader>snd` | n | Dismiss all notifications |
| `<C-f>` | i/n/s | Scroll LSP hover forward |
| `<C-b>` | i/n/s | Scroll LSP hover backward |

Noice is temporarily disabled when LeaderF is active (via FileType/BufLeave autocmds) to prevent its popup stealing focus from LeaderF's input window. When you leave LeaderF, noice is automatically re-enabled.

### nvim-spectre

> Spectre lets you "find the enemy and replace them with dark power" -- it provides a project-wide search and replace panel that finds text patterns across all files in your workspace and replaces them in bulk, with live preview of replacements before committing.

| Key | Mode | Action |
|---|---|---|
| `<leader>sr` | n | Open spectre (search & replace across files) |

### nvim-cmp

> nvim-cmp is a completion plugin for Neovim coded in Lua. It provides intelligent auto-completion as you type, drawing from multiple sources (LSP, buffer words, file paths, snippets). It supports ghost text (inline preview), documentation scrolling, and snippet expansion integration.

| Key | Mode | Action |
|---|---|---|
| `<Tab>` | i | Select next completion item / expand snippet |
| `<S-Tab>` | i | Select previous completion item |
| `<C-b>` | i | Scroll documentation down |
| `<C-f>` | i | Scroll documentation up |
| `<C-Space>` | i | Trigger completion manually |
| `<C-e>` | i | Abort completion |
| `<CR>` (Enter) | i | Confirm selected item |

Sources: nvim_lsp, buffer, path, luasnip. Ghost text (inline preview) is enabled.

### LuaSnip

> LuaSnip is a snippet engine written in Lua. It supports expanding snippets by trigger keyword, jumping between snippet tabstops, and loading VSCode-style snippet collections (via friendly-snippets). Snippets can be custom-defined in Lua for any language.

| Key | Mode | Action |
|---|---|---|
| `<Tab>` | i | Expand snippet or jump forward |
| `<Tab>` | s | Jump to next snippet node |
| `<S-Tab>` | i/s | Jump to previous snippet node |

Uses friendly-snippets as the snippet collection.

### auto-session

> Auto-session is a small automated session manager for Neovim. It automatically saves your editing session (open buffers, window layout, cursor positions) on exit and restores it on re-entry, per working directory. This means you can switch projects and come back to exactly where you left off.

| Key | Mode | Action |
|---|---|---|
| `<leader>Ss` | n | Save current session |
| `<leader>Sl` | n | Search and load a session |

Sessions are auto-saved on exit and auto-restored on enter (per directory). Suppressed in home, Downloads, and zettelkasten directories. Session name is shown in the lualine statusline.

### markdown-preview

> Markdown-preview.nvim is a markdown preview plugin for (Neo)vim that opens a browser tab and live-renders the current markdown file as you edit. It supports real-time synchronization, Mermaid/KaTeX/UML diagrams, and works with both markdown and telekasten filetypes.

| Key | Mode | Action |
|---|---|---|
| `<leader>mp` | n/i | Start markdown preview |
| `<leader>ms` | n/i | Stop markdown preview |
| `<leader>mt` | n/i | Toggle markdown preview |

Opens a browser tab that live-renders the current markdown file. Supports telekasten filetype as well.

### Telekasten

> Telekasten.nvim is a Neovim plugin for Zettelkasten-style note-taking. It provides a complete workflow: find/search notes, follow links, create daily/weekly notes from templates, paste images with auto-linking, show backlinks and tags, browse media, and rename notes while auto-updating all references. Note vault is at `~/zettelkasten`.

All telekasten keys use `<leader>z` prefix.

| Key | Mode | Action |
|---|---|---|
| `<leader>zf` | n | Find notes |
| `<leader>zd` | n | Find daily notes |
| `<leader>zg` | n | Search notes (grep) |
| `<leader>zz` | n | Follow link under cursor |
| `<leader>zT` | n | Go to today's daily note |
| `<leader>zW` | n | Go to this week's weekly note |
| `<leader>zw` | n | Find weekly notes |
| `<leader>zn` | n | New note |
| `<leader>zN` | n | New templated note |
| `<leader>zy` | n | Yank note link |
| `<leader>zc` | n | Show calendar |
| `<leader>zC` | n | Full calendar view |
| `<leader>zi` | n | Paste image and insert link |
| `<leader>zt` | n | Toggle TODO status |
| `<leader>zb` | n | Show backlinks |
| `<leader>zF` | n | Find friends (linked notes) |
| `<leader>zI` | n | Insert image link |
| `<leader>zp` | n | Preview image |
| `<leader>zm` | n | Browse media files |
| `<leader>za` | n | Find tags |
| `<leader>zr` | n | Rename note (updates all links) |
| `<leader>z[` | i | Insert link (insert mode) |
| `<leader>za` | i | Insert link by tag (insert mode) |

Notes use `.md` extension. Templates are in `~/zettelkasten/templates/`. This uses a custom fork (`ABigBright/telekasten.nvim`, branch `cus_for_briq`).

### Orgmode

> Orgmode brings Emacs Org-mode functionality to Neovim. It provides org agenda views (day/week/month), org capture for quick task entry, TODO state cycling (TODO/WAIT/DONE/ASSIGN/CANCEL), deadlines and scheduling, date manipulation, clocking, and refiling. Your tasks and notes live in `.org` files under `~/zettelkasten/org/`.

Orgmode uses `<leader>o` as its mapping prefix. Key highlights:

| Key | Mode | Action |
|---|---|---|
| `<leader>oa` | n | Open org agenda |
| `<leader>oc` | n | Org capture |
| `<leader>or` | n | Refile |
| `<leader>oit` | n | Insert TODO heading |
| `<leader>oid` | n | Set deadline |
| `<leader>ois` | n | Set schedule |
| `<C-a>` | n | Increase date |
| `<C-x>` | n | Decrease date |
| `cit` | n | Cycle TODO state |
| `<leader>o*` | n | Toggle heading |

Agenda files: `~/zettelkasten/org/agenda/*.org` and `~/zettelkasten/org/work/weekly/todo.org`. Refile target: `~/zettelkasten/org/agenda/refile.org`. TODO keywords: TODO, WAIT, DONE, ASSIGN, CANCEL.

### todo-comments

> Todo-comments highlights, lists and searches todo comments (like TODO, FIXME, HACK, WARN, PERF, NOTE) in your projects. It adds colored icons in the sign column and highlights the keywords in code, plus provides quick search commands to find all TODOs or FIXMEs across your workspace.

| Key | Mode | Action |
|---|---|---|
| `<leader>tsa` | n | Search all (FIXME,TODO,XXX,HACK) |
| `<leader>tsf` | n | Search FIXME |
| `<leader>tst` | n | Search TODO |
| `<leader>tsx` | n | Search XXX |
| `<leader>tsh` | n | Search HACK |
| `<leader>tsc` | n | Custom keyword search (type keywords + cwd after) |

### Tabular

> Tabular lets you align text by any pattern (like `=`, `,`, `|`, etc.). Select lines in visual mode or specify a range, type the pattern to align by, and Tabular automatically spaces the columns. Useful for formatting tables, aligning assignments, and cleaning up code.

| Key | Mode | Action |
|---|---|---|
| `<leader>si` | n/v | Tabularize by pattern (type pattern after, e.g. `<leader>si =` to align by `=`) |

### Treesitter

> Nvim-treesitter provides Nvim Treesitter configurations and abstraction layer. It uses tree-sitter parsers for accurate syntax highlighting (not regex-based), indentation, and incremental code selection. You can select code blocks by syntax node (function, block, statement) and expand/shrink the selection incrementally.

| Key | Mode | Action |
|---|---|---|
| `<C-Space>` | n | Start/increment node selection |
| `<BS>` (Backspace) | x | Decrement node selection (visual mode) |

### nvim-notify

> Nvim-notify is a fancy, configurable notification manager for NeoVim. It replaces the default `vim.notify` with animated, styled popup notifications that can be dismissed, browsed, and configured with timeout/max dimensions.

| Key | Mode | Action |
|---|---|---|
| `<leader>un` | n | Dismiss all pending notifications |

### Venn

> Venn.nvim lets you draw ASCII diagrams (boxes, lines, arrows) directly in your text buffer. Toggle drawing mode on, then use H/J/K/L to draw lines and `f` in visual mode to draw boxes around selections. Useful for creating simple flowcharts and architecture diagrams in markdown or plain text.

| Key | Mode | Action |
|---|---|---|
| `<leader>v` | n | Toggle venn drawing mode |

When venn is active: H/J/K/L draw lines, `f` (visual mode) draws a box around selection. Note: this plugin is **disabled by default** (`enabled = false`). Set it to `true` in `lua/plugins/venn.lua` to activate.

### Telescope

> Telescope is a highly extendable fuzzy finder that helps you find, filter, preview and pick from anything in Neovim. It provides builtin pickers for files, buffers, grep, tags, help, marks, keymaps, commands, and more -- all powered by a Lua-first architecture with fzf-native extension for fast sorting.

Configured with fzf-native extension for fast fuzzy sorting and media-files extension for image preview. See the FZF section for the keybindings that use fzf.vim commands directly. Telescope itself serves as the backend picker for telekasten, dressing.nvim, and other plugins.

### Which-key

> Which-key helps you remember your Neovim keymaps by showing available keybindings in a popup as you type. Press the leader key and wait, and a popup appears listing all possible next keys with their descriptions, organized into groups. This makes it easy to discover and recall any binding without memorizing them all.

Press `<leader>` and wait ~200ms. which-key shows a popup with all groups and single-key bindings registered under that prefix. Groups defined:

- `<leader>b` -- buffer
- `<leader>c` -- comment
- `<leader>d` -- close window
- `<leader>e` -- lsp
- `<leader>f` -- file/find
- `<leader>h` -- help
- `<leader>j` -- jump (gtags)
- `<leader>l` -- move (easymotion)
- `<leader>m` -- markdown
- `<leader>o` -- orgmode
- `<leader>q` -- quickfix
- `<leader>s` -- search/style
- `<leader>sn` -- noice
- `<leader>S` -- session
- `<leader>t` -- tag/todo
- `<leader>w` -- windows
- `<leader>z` -- zettelkasten

### Lualine

> Lualine is a fast and customizable statusline plugin. This config uses a custom fork (`ABigBright/lualine.nvim`, branch `cus_for_briq`) that shows: window list, git branch, diagnostics, filename with path, code context (navic), session name, current function (vista), noice command/mode indicator, DAP status, lazy plugin updates, git diff stats, progress, location, and clock.

No explicit keybindings -- lualine is always visible in the statusline.

## Plugins Without Explicit Keybindings

These plugins are loaded on `VeryLazy` event or automatically, with no custom keys set:

| Plugin | Description | How to Use |
|---|---|---|
| **vim-surround** | Delete/change/add parentheses, quotes, XML-tags and much more with ease. Surround any text object with any delimiter, or change existing surrounding delimiters. | `cs"'` -- change surrounding `"` to `'` / `ds"` -- delete surrounding `"` / `ysiw"` -- surround word with `"` / `yss)` -- surround entire line with `()` |
| **vim-visual-multi** | Multiple cursors plugin for vim/neovim. Select multiple instances of the same word and edit them all simultaneously. | `<C-n>` -- select word under cursor and start multi-cursor / `<C-n>/<C-p>` -- add/remove next match / `<Esc>` twice -- exit multi-cursor mode |
| **nerdcommenter** | Comment/uncomment code with a single keypress. Supports many filetypes with language-specific comment delimiters, compact sexy-comments, and toggling. | `<leader>cc` -- comment line / `<leader>cu` -- uncomment / `<leader>ci` -- invert comment / `<leader>cs` -- sexy-comment |
| **vim-fugitive** | A Git wrapper so awesome, it should be illegal. Provides a full Git workflow inside Neovim: status, blame, diff, log, commit, merge, and more. | `:Git` -- git status / `:Git blame` -- blame / `:Git diff` -- diff / `:Gwrite` -- stage file / `:Gread` -- checkout file |
| **vim-rhubarb** | GitHub extension for fugitive.vim. Lets you open the current file or line on GitHub in your browser with a single command. | `:GBrowse` -- open current line/file on GitHub |
| **fugitive-gitlab.vim** | Extends fugitive for GitLab integration, providing `:GBrowse` for GitLab URLs and GitLab API integration for browse/follow. | Configure `vim.g.fugitive_gitlab_domains` and `vim.g.gitlab_api_keys` for your GitLab instance, then `:GBrowse` works for GitLab |
| **vim-gitgutter** | Shows git diff markers in the sign column (added/changed/deleted lines), and provides stage/revert/preview operations on individual hunks. | `[c` / `]c` -- jump between changes / `<leader>hp` -- preview hunk / `<leader>hu` -- undo hunk |
| **vim-rooter** | Automatically changes Vim's working directory to the project root (detected by `.root` or `.git` marker files) when you open a file. | Works automatically; no keys needed |
| **vim-markdown-toc** | Generate and update markdown table of contents (TOC). Supports GitHub-flavored markdown (GFM) and standard markdown formats. | `:GenTocGFM` -- generate GFM TOC / `:GenTocMarkdown` -- standard TOC / `:UpdateToc` -- refresh existing TOC |
| **dressing.nvim** | Neovim plugin to improve the default `vim.ui.select` and `vim.ui.input` interfaces. Replaces the boring default prompts with styled floating windows using telescope/fzf-style UI. | Works automatically when any plugin calls `vim.ui.select` or `vim.ui.input` |
| **nvim-bqf** | Better quickfix list. Enhances the built-in quickfix window with fzf integration, preview window, and syntax highlighting, making `:copen` much more useful. | Works automatically in quickfix windows |
| **nvim-lspconfig** | Neovim LSP configuration helper. Provides quickstart configurations for the built-in LSP client, connecting Neovim to language servers like clangd, lua_ls, jsonls, etc. | Works automatically; LSP servers are configured in `nvim-cmp.lua` |

## Color Scheme

Three themes are configured and loaded on startup (in `lua/trigger/colorscheme.lua`):

- **tokyonight** (style: moon) -- loaded first
- **monokai-pro** -- loaded second (overrides tokyonight as the active theme)
- **catppuccin** -- available but not loaded by default

To switch theme, use `:colorscheme tokyonight` or `:colorscheme catppuccin`.

## LSP Integration

This config uses nvim-lspconfig (included as a dependency of nvim-cmp) for LSP. Capabilities are configured for clangd, jsonls, and lua_ls. To add more LSP servers, edit `lua/plugins/nvim-cmp.lua` and add entries to the `vim.lsp.config()` calls in the config function.

Alternatively, you can install and configure language servers via Mason (`:Mason`).

## Vim Options Summary

Set in `lua/config/options.lua`:

| Option | Value | Meaning |
|---|---|---|
| mapleader | Space | Leader key |
| maplocalleader | Space | Local leader key |
| number | true | Show line numbers |
| relativenumber | true | Show relative line numbers |
| mouse | a | Enable mouse |
| smartindent | true | Smart auto-indent |
| cindent | true | C-style indenting |
| autoindent | true | Keep indent on new lines |
| splitbelow | true | Horizontal splits go below |
| splitright | true | Vertical splits go right |
| wildmenu | true | Enhanced command-line completion menu |
| scrolloff | 5 | Keep 5 lines above/below cursor |
| termguicolors | true | True color support |
| conceallevel | 3 | Hide concealed text (markdown links, etc.) |
| cursorline | true | Highlight current line |
| hlsearch | true | Highlight search results |
| tabstop | 4 | Tab width |
| shiftwidth | 4 | Indent width |
| expandtab | true | Convert tabs to spaces |
| encoding | utf-8 | File encoding |
| fileformat | unix | Line endings |
| backup | false | No backup files |
| updatetime | 500 | Swap write interval (also affects gitgutter) |

On macOS, `guifont` is set to `FiraMono Nerd Font Mono:h13`. On Windows, Python paths are hardcoded.

## Adding/Removing Plugins

1. Create a new file in `lua/plugins/` (e.g. `lua/plugins/my-plugin.lua`) returning a lazy.nvim spec table.
2. Or edit an existing file in `lua/plugins/`.
3. Restart Neovim or run `:Lazy` to manage plugins.

To disable a plugin, set `enabled = false` in its spec (see `lua/plugins/venn.lua` for an example).

## Tips

- Press `<Space>` and wait to see all available keybindings via which-key.
- Use `<leader>ff` (LeaderF) for fast file finding; `<leader>jd` for jumping to definitions.
- Use `<leader>fc` (neo-tree) to browse files visually; it auto-closes after opening a file.
- Use `<leader>mp` to preview markdown in your browser while editing.
- Use `<leader>zf` to find Zettelkasten notes; `<leader>zn` to create new ones.
- Use `<leader>Ss` to save a session before switching projects; `<leader>Sl` to restore.
- Run `:Lazy` to check for plugin updates (auto-checker is enabled, notifications suppressed).