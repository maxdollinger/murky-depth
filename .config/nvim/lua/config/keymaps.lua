-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby

vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "O", 'o<Esc>0"_D', { silent = true, desc = "inserts new empty line without insert mode" })
vim.keymap.set("n", "<c-d>", "<c-d>zz", { silent = true })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { silent = true })
vim.keymap.set({ "v", "n" }, "p", [["0P]], { silent = true })
vim.keymap.set({ "v" }, "Y", [["+y]], { silent = true })
vim.keymap.set("i", "<c-l>", "<right>", { silent = true })
vim.keymap.set("i", "<c-h>", "<left>", { silent = true })
vim.keymap.set("i", "<c-k>", "<up>", { silent = true })
vim.keymap.set("i", "<c-j>", "<down>", { silent = true })
