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
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }
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
                        },
                    },
                    initial_mode = 'normal',
                },
                pickers = {
                    find_files = {
                        initial_mode = 'insert',
                    },
                    live_grep = {
                        initial_mode = 'insert',
                    },
                    file_browser = {
                        initial_mode = 'insert',
                    },
                },
                extensions = {},
            }

            local hijack_netrw = function()
                local netrw_bufname

                -- clear FileExplorer appropriately to prevent netrw from launching on folders
                -- netrw may or may not be loaded before telescope-file-browser config
                -- conceptual credits to nvim-tree
                pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
                vim.api.nvim_create_autocmd("VimEnter", {
                    pattern = "*",
                    once = true,
                    callback = function()
                        pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
                    end,
                })
                vim.api.nvim_create_autocmd("BufEnter", {
                    group = vim.api.nvim_create_augroup("telescope-find-files.nvim", { clear = true }),
                    pattern = "*",
                    callback = function()
                        vim.schedule(function()
                            if vim.bo[0].filetype == "netrw" then
                                return
                            end
                            local bufname = vim.api.nvim_buf_get_name(0)
                            if vim.fn.isdirectory(bufname) == 0 then
                                _, netrw_bufname = pcall(vim.fn.expand, "#:p:h")
                                return
                            end

                            -- prevents reopening of file-browser if exiting without selecting a file
                            if netrw_bufname == bufname then
                                netrw_bufname = nil
                                return
                            else
                                netrw_bufname = bufname
                            end

                            -- ensure no buffers remain with the directory name
                            vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")

                            require("telescope.builtin").find_files({
                                cwd = vim.fn.expand "%:p:h",
                                hidden = true,
                            })
                        end)
                    end,
                    desc = "telescope-find-files.nvim replacement for netrw",
                })
            end

            hijack_netrw()

            pcall(require('telescope').load_extension, 'fzf')
            require("telescope").load_extension "file_browser"
            require("telescope").load_extension("ui-select")

            local pickers = require('telescope.builtin')

            vim.keymap.set('n', '<leader><space>', pickers.buffers, { desc = 'show open buffers' })
            vim.keymap.set('n', '<leader>sb', pickers.current_buffer_fuzzy_find, { desc = 'search current [b]uffer' })
            vim.keymap.set('n', '<leader>p', pickers.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh', pickers.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', pickers.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', pickers.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>gd', pickers.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>ss', pickers.lsp_document_symbols, { desc = 'Document [S]ymbols' })
            vim.keymap.set('n', '<leader>e', ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
                { desc = 'File [E]explorer' })
            vim.keymap.set('n', 'gd', pickers.lsp_definitions, { desc = '[G]oto [D]efinition' })
            vim.keymap.set('n', 'gr', pickers.lsp_references, { desc = '[G]oto [R]eferences' })
            vim.keymap.set('n', 'gI', pickers.lsp_implementations, { desc = '[G]oto [I]mplementation' })
        end
    },
}
