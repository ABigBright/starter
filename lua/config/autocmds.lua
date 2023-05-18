-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- add q key for quit specified filetype windows
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"help", "qf"},
    callback = function(ev)
        vim.keymap.set({"n"}, "q", "<cmd>q!<cr>", {silent = true, buffer = true})
    end
})

