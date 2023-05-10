-- keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- some misc setting config keybind
vim.keymap.set({"n"}, "S", "<cmd>w!<cr>")
vim.keymap.set({"n"}, "Q", "<cmd>q!<cr>")
vim.keymap.set({"n"}, "R", ":source $MYVIMRC<cr>", {silent = false})

-- in normal mode
-- move after search
vim.keymap.set({"n"}, "n", "nzz")
vim.keymap.set({"n"}, "N", "Nzz")

-- windown resize
vim.keymap.set({"n"}, "<C-j>", "<cmd>resize +5<cr>", {silent = true})
vim.keymap.set({"n"}, "<C-k>", "<cmd>resize -5<cr>", {silent = true})
vim.keymap.set({"n"}, "<M-j>", "<cmd>vertical resize -5<cr>", {silent = true})
vim.keymap.set({"n"}, "<M-k>", "<cmd>vertical resize +5<cr>", {silent = true})

-- window move
vim.keymap.set({"n"}, "<leader>1", "<cmd>1wincmd w<cr>", {silent = true, desc = "which_key_ignore"})
vim.keymap.set({"n"}, "<leader>2", "<cmd>2wincmd w<cr>", {silent = true, desc = "which_key_ignore"})
vim.keymap.set({"n"}, "<leader>3", "<cmd>3wincmd w<cr>", {silent = true, desc = "which_key_ignore"})
vim.keymap.set({"n"}, "<leader>4", "<cmd>4wincmd w<cr>", {silent = true, desc = "which_key_ignore"})
vim.keymap.set({"n"}, "<leader>5", "<cmd>5wincmd w<cr>", {silent = true, desc = "which_key_ignore"})
vim.keymap.set({"n"}, "<leader>6", "<cmd>6wincmd w<cr>", {silent = true, desc = "which_key_ignore"})
vim.keymap.set({"n"}, "<leader>7", "<cmd>7wincmd w<cr>", {silent = true, desc = "which_key_ignore"})
vim.keymap.set({"n"}, "<leader>8", "<cmd>8wincmd w<cr>", {silent = true, desc = "which_key_ignore"})
vim.keymap.set({"n"}, "<leader>9", "<cmd>9wincmd w<cr>", {silent = true, desc = "which_key_ignore"})

-- window split
vim.keymap.set({"n"}, "<leader>wr", ":set splitright<cr>:vert split<cr>", {silent = true})
vim.keymap.set({"n"}, "<leader>wl", ":set nosplitright<cr>:vert split<cr>", {silent = true})
vim.keymap.set({"n"}, "<leader>wb", ":set splitbelow<cr>:split<cr>", {silent = true})
vim.keymap.set({"n"}, "<leader>wu", ":set nosplitbelow<cr>:split<cr>", {silent = true})
vim.keymap.set({"n"}, "<leader>wo", "<C-W>o", {silent = true})
vim.keymap.set({"n"}, "<leader>wh", "<C-W>t<C-W>K", {silent = true})
vim.keymap.set({"n"}, "<leader>wv", "<C-W>t<C-W>H", {silent = true})
vim.keymap.set({"n"}, "<leader>wp", "<c-w>p", {silent = true})

