return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            flavour = "frappe", -- latte, frappe, macchiato, mocha
            background = {
                -- :h background
                light = "latte",
                dark = "frappe",
            },
            transparent_background = false,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                telescope = true,
            }
        })

        vim.cmd.colorscheme 'catppuccin'
    end
}
