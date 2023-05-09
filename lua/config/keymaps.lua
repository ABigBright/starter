-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- some misc setting config keybind
vim.keymap.set({"n"}, "S", "<cmd>w!<cr>")
vim.keymap.set({"n"}, "Q", "<cmd>q!<cr>")
vim.keymap.set({"n"}, "R", ":source $MYVIMRC<cr>", {silent = false})
-- in normal mode
vim.keymap.set({"n"}, "n", "nzz")
vim.keymap.set({"n"}, "N", "Nzz")
vim.keymap.set({"n"}, "<C-j>", "<cmd>resize +5<cr>", {silent = true})
vim.keymap.set({"n"}, "<C-k>", "<cmd>resize -5<cr>", {silent = true})

vim.keymap.set({"n"}, "<M-j>", "<cmd>vertical resize -5<cr>", {silent = true})
vim.keymap.set({"n"}, "<M-k>", "<cmd>vertical resize +5<cr>", {silent = true})
