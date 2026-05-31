-- keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- some misc setting config keybind
vim.keymap.set({ "n" }, "S", "<cmd>w!<cr>", { desc = "Save file" })
vim.keymap.set({ "n" }, "Q", "<cmd>q!<cr>", { desc = "Quit" })
vim.keymap.set({ "n" }, "R", ":source $MYVIMRC<cr>", { silent = false, desc = "Reload config" })

-- in normal mode
-- move and deselect after search
vim.keymap.set({ "n" }, "n", "nzz", { desc = "Search next (centered)" })
vim.keymap.set({ "n" }, "N", "Nzz", { desc = "Search prev (centered)" })
vim.keymap.set({ "n" }, "<leader><cr>", "<cmd>noh<cr>", { silent = true, desc = "which_key_ignore" })

-- windown resize
vim.keymap.set({ "n" }, "<C-j>", "<cmd>resize +5<cr>", { silent = true, desc = "Increase height" })
vim.keymap.set({ "n" }, "<C-k>", "<cmd>resize -5<cr>", { silent = true, desc = "Decrease height" })
vim.keymap.set({ "n" }, "<M-j>", "<cmd>vertical resize -5<cr>", { silent = true, desc = "Decrease width" })
vim.keymap.set({ "n" }, "<M-k>", "<cmd>vertical resize +5<cr>", { silent = true, desc = "Increase width" })

-- window move
vim.keymap.set({ "n" }, "<leader>1", "<cmd>1wincmd w<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>2", "<cmd>2wincmd w<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>3", "<cmd>3wincmd w<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>4", "<cmd>4wincmd w<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>5", "<cmd>5wincmd w<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>6", "<cmd>6wincmd w<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>7", "<cmd>7wincmd w<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>8", "<cmd>8wincmd w<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>9", "<cmd>9wincmd w<cr>", { silent = true, desc = "which_key_ignore" })

vim.keymap.set({ "n" }, "<leader>d1", "<cmd>1quit!<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>d2", "<cmd>2quit!<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>d3", "<cmd>3quit!<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>d4", "<cmd>4quit!<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>d5", "<cmd>5quit!<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>d6", "<cmd>6quit!<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>d7", "<cmd>7quit!<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>d8", "<cmd>8quit!<cr>", { silent = true, desc = "which_key_ignore" })
vim.keymap.set({ "n" }, "<leader>d9", "<cmd>9quit!<cr>", { silent = true, desc = "which_key_ignore" })

-- window split
vim.keymap.set({ "n" }, "<leader>wr", ":set splitright<cr>:vert split<cr>", { silent = true, desc = "Split right" })
vim.keymap.set({ "n" }, "<leader>wl", ":set nosplitright<cr>:vert split<cr>", { silent = true, desc = "Split left" })
vim.keymap.set({ "n" }, "<leader>wb", ":set splitbelow<cr>:split<cr>", { silent = true, desc = "Split below" })
vim.keymap.set({ "n" }, "<leader>wu", ":set nosplitbelow<cr>:split<cr>", { silent = true, desc = "Split above" })
vim.keymap.set({ "n" }, "<leader>wo", "<C-W>o", { silent = true, desc = "Close other windows" })
vim.keymap.set({ "n" }, "<leader>wh", "<C-W>t<C-W>K", { silent = true, desc = "Convert to horizontal" })
vim.keymap.set({ "n" }, "<leader>wv", "<C-W>t<C-W>H", { silent = true, desc = "Convert to vertical" })
vim.keymap.set({ "n" }, "<leader>wp", "<c-w>p", { silent = true, desc = "Previous window" })

-- neovim config file dir and path
vim.keymap.set({ "n" }, "<leader>hi", function()
  local p = vim.fn.stdpath("config") .. "/lua/config/lazy.lua"
  vim.cmd({ cmd = "e", args = { p } })
end, { silent = true, desc = "Open init config" })
vim.keymap.set({ "n" }, "<leader>hp", function()
  local p = vim.fn.stdpath("config") .. "/lua/plugins/"
  vim.cmd({ cmd = "Neotree", args = { p } })
end, { silent = true, desc = "Open plugin config" })
vim.keymap.set({ "n" }, "<leader>hk", function()
  local p = vim.fn.stdpath("config") .. "/lua/config/keymaps.lua"
  vim.cmd({ cmd = "e", args = { p } })
end, { silent = true, desc = "Open keymaps config" })
vim.keymap.set({ "n" }, "<leader>hP", function()
  local p = vim.fn.stdpath("data") .. "/lazy/"
  vim.cmd({ cmd = "Neotree", args = { p } })
end, { silent = true, desc = "Open installed plugins" })

-- lazy plug manager
vim.keymap.set({ "n" }, "<leader>hl", "<cmd>Lazy<cr>", { silent = true, desc = "Plugin manager" })

-- quickfix
vim.keymap.set({ "n" }, "<leader>qo", "<cmd>botright cw 10<cr>", { silent = true, desc = "Open quickfix" })
vim.keymap.set({ "n" }, "<leader>qc", "<cmd>ccl<cr>", { silent = true, desc = "Close quickfix" })


-- graph-easy
-- vim.keymap.set({ "v" }, "<leader>ga", ":'<,'>%!graph-easy --as=ascii <cr>", { silent = true, desc = "dot to ascii" })
