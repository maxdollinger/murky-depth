return {
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                            ['<Cr>'] = { "<esc>", type = "command" },
                        },
                    },
                    initial_mode = 'normal',
                },
            }

            pcall(require('telescope').load_extension, 'fzf')

            local pickers = require('telescope.builtin')

            vim.keymap.set('n', '<leader><space>', pickers.buffers, { desc = 'show open buffers' })
            vim.keymap.set('n', '<leader>sb', pickers.current_buffer_fuzzy_find, { desc = 'search current [b]uffer' })
            vim.keymap.set('n', '<leader>sf', pickers.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh', pickers.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', pickers.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', pickers.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', pickers.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>ss', pickers.lsp_document_symbols, { desc = 'Document [S]ymbols' })
        end
    },
}
