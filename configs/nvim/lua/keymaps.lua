vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', 'F', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

vim.keymap.set("n", "<c-d>", "<c-d>zz", { silent = true })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "O", 'o<Esc>0"_D', { silent = true, desc = "inserts new empty line without insert mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves selected text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves selected text up" })

vim.keymap.set("n", "<leader>w", vim.cmd.w, { silent = true, desc = "[W]rite buffer" })
vim.keymap.set("i", "<c-j>", "<down>", { silent = true })
vim.keymap.set("i", "<c-k>", "<up>", { silent = true })
vim.keymap.set("i", "<c-h>", "<left>", { silent = true })
vim.keymap.set("i", "<c-l>", "<right>", { silent = true })
vim.keymap.set({ "v", "n" }, "p", [["0P]], { silent = true })
vim.keymap.set({ "v" }, "Y", [["+y]], { silent = true })

vim.keymap.set("n", "<leader><esc>", "<cmd>confirm q<cr>", { silent = true, desc = "[Q]uit buffer" })

vim.keymap.set('n', '<leader>e', function()
        local reveal_file = vim.fn.expand('%:p')
        if (reveal_file == '') then
            reveal_file = vim.fn.getcwd()
        else
            local f = io.open(reveal_file, "r")
            if (f) then
                f.close(f)
            else
                reveal_file = vim.fn.getcwd()
            end
        end
        require('neo-tree.command').execute({
            action = "focus",          -- OPTIONAL, this is the default value
            source = "filesystem",     -- OPTIONAL, this is the default value
            position = "float",        -- OPTIONAL, this is the default value
            reveal_file = reveal_file, -- path to file or folder to reveal
            reveal_force_cwd = true,   -- change cwd without asking if needed
        })
    end,
    { desc = "Open neo-tree at current file or working directory" }
);
