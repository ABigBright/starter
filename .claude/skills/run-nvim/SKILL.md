---
name: run-nvim
description: Build, run, and drive this Neovim configuration. Use when asked to start nvim, run its config, take a screenshot of its UI, verify a plugin loads, check health, or interact with the running editor.
---

Personal Neovim config based on lazy.nvim, originally forked from LazyVim. Drive it via `.claude/skills/run-nvim/driver.sh` under tmux for interactive use, or `nvim --headless` for direct config-module invocation. All paths below are relative to the project root (`~/.config/nvim`).

## Prerequisites

External tools needed by plugins (all already present on this system):

```bash
sudo apt-get update
sudo apt-get install -y neovim git ripgrep silver-searcher universal-ctags global fzf nodejs python3 tmux
```

A Nerd Font is required for icons in lualine, neo-tree, and which-key. tmux must be available for interactive driving. Use `/usr/bin/tmux` directly if the shell aliases it.

## Setup

On a fresh clone, lazy.nvim bootstraps itself and installs all plugins on first launch:

```bash
nvim  # first launch -- wait for plugin install/build to finish, then restart
```

To force a clean reinstall of plugins:

```bash
rm -rf ~/.local/share/nvim/lazy
nvim --headless -c 'lua require("lazy").install()' -c 'q' 2>&1
```

## Build

No separate build step. Plugins with build steps (markdown-preview, LeaderF, fzf, telescope-fzf-native) are built by lazy.nvim during install.

## Run (agent path -- interactive)

Use the driver script to launch nvim inside tmux, send keys, capture output, and quit:

```bash
# Launch nvim with a specific file (default: init.lua)
bash .claude/skills/run-nvim/driver.sh launch lua/config/options.lua

# Capture the current screen
bash .claude/skills/run-nvim/driver.sh capture

# Send keys (tmux send-keys syntax -- Enter for Enter key, special keys like Down/Up/Escape)
bash .claude/skills/run-nvim/driver.sh send ":e lua/config/keymaps.lua"
bash .claude/skills/run-nvim/driver.sh send Enter

# Wait for a pattern to appear on screen (polls every 0.3s, faster than fixed sleep)
bash .claude/skills/run-nvim/driver.sh wait "keymaps.lua"

# Quit the session
bash .claude/skills/run-nvim/driver.sh quit
```

For quick smoke tests that launch, interact, capture, and quit in one shot:

```bash
bash .claude/skills/run-nvim/driver.sh lazy            # open Lazy UI, capture, quit
bash .claude/skills/run-nvim/driver.sh neotree         # open Neo-tree, capture, quit
bash .claude/skills/run-nvim/driver.sh telescope       # open Telescope find_files, capture, quit
bash .claude/skills/run-nvim/driver.sh telescope live_grep  # Telescope live_grep variant
```

Or use raw tmux commands (the driver wraps these):

```bash
/usr/bin/tmux new-session -d -s nvim -x 120 -y 40 'nvim init.lua'
timeout 10 bash -c 'until /usr/bin/tmux capture-pane -t nvim -p | grep -q "require"; do sleep 0.3; done'
/usr/bin/tmux capture-pane -t nvim -p
/usr/bin/tmux send-keys -t nvim ':qa' Enter
/usr/bin/tmux kill-session -t nvim 2>/dev/null
```

### Key reference (for driving the editor)

| Keys | Action |
|---|---|
| `Space` (leader) | Opens which-key (200ms delay) -- may error in tmux without Nerd Font icons |
| `:Lazy` | Opens Lazy plugin manager UI |
| `:Neotree` / `:Neotree close` | Opens/closes file sidebar |
| `:Telescope find_files` | Opens file finder |
| `:Telescope live_grep` | Opens grep search |
| `:qa` | Quit all buffers |
| `:e <path>` | Open file at path |
| `S` (normal mode) | Save file |
| `Q` (normal mode) | Quit buffer |
| `Escape` | Dismiss popups (which-key, telescope, noice) |

## Direct invocation (headless -- for config internals)

Most PRs to this repo touch config modules (options, keymaps, plugin specs). Headless mode lets you import and call them directly, no tmux needed:

```bash
# Load a config module and check it works
nvim --headless -c 'lua print(require("config.options"))' -c 'q' 2>&1
# -> true

# Call a util function
nvim --headless -c 'lua print(require("util").get_root())' -c 'q' 2>&1
# -> "/home/briq/.config/nvim"

# List all functions in a module
nvim --headless -c 'lua for k,v in pairs(require("util")) do print(k, type(v)) end' -c 'q' 2>&1

# Run checkhealth
nvim --headless -c 'checkhealth' -c 'q' 2>&1
```

For testing a single plugin spec loads without error:

```bash
nvim --headless -c 'lua print(require("plugins.nvim-cmp"))' -c 'q' 2>&1
```

## Run (human path)

```bash
nvim  # opens editor in terminal. :qa or Q to quit.
```

## Test

No formal test suite. Verify via:

```bash
# Health check
nvim --headless -c 'checkhealth' -c 'q' 2>&1

# Verify lazy.nvim can load all specs
nvim --headless -c 'lua require("lazy").load()' -c 'q' 2>&1

# Verify a specific plugin spec
nvim --headless -c 'lua print(require("plugins.telescope"))' -c 'q' 2>&1
```

## Gotchas

- **which-key errors in tmux without proper fonts** -- pressing Space (leader) in tmux triggers `attempt to index field 'm'` in which-key's icons.lua. The config expects Nerd Font icon support; tmux with a basic terminal doesn't provide it. Use `:command` mode instead of leader keys when driving via tmux, or set `TERM=xterm-256color` and install a Nerd Font.

- **nvim exits when only buffer is closed** -- if you `:q` the sole open buffer, nvim terminates entirely (the tmux session dies). Use `:e <other-file>` before `:q` if you need to keep nvim alive while switching files, or open nvim with a file argument.

- **noice popup overlays** -- the noice plugin shows messages/cmdline in a floating popup. In tmux, these overlay the buffer content and may confuse `capture-pane`. Wait 3-5 seconds for popups to auto-dismiss, or send `Escape` to close them.

- **deprecation warnings on nvim 0.12** -- `vim.tbl_islist` is deprecated in nvim 0.12+. The config's LazyVim utility layer (`config/init.lua`) may trigger this. It's cosmetic; the config still loads correctly.

- **tmux is aliased to a zsh plugin function** -- the shell alias `tmux` points to `_zsh_tmux_plugin_run`, which isn't a real command. Use `/usr/bin/tmux` directly in scripts and driver commands.

- **lazy-loaded plugins** -- most plugins are lazy-loaded (on event/command/key). In headless mode, only the bootstrap plugins are loaded. To test a specific plugin, use `nvim --headless -c 'lua require("lazy").load({plugins={"telescope.nvim"}})' -c 'q'` or open the relevant file interactively to trigger the load event.

## Troubleshooting

- **`can't find pane: nvim` after sending :q**: nvim terminated because it was the only buffer. The tmux session is gone. Restart with `driver.sh launch`.
- **blank capture-pane output**: nvim hasn't finished rendering. Use `driver.sh wait <pattern>` instead of fixed sleep.
- **`command not found: _zsh_tmux_plugin_run`**: the `tmux` shell alias conflicts. Use `/usr/bin/tmux` or the driver script which uses the full path.
