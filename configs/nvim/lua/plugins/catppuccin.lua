return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            flavour = "frappe", -- latte, frappe, macchiato, mocha
            background = {
                light = "latte",
                dark = "frappe",
            },
            transparent_background = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                telescope = true,
            },
            custom_highlights = function(colors)
                return {
                    LineNr = { fg = colors.subtext1 },
                    Visual = { bg = colors.text, fg = colors.base },
                }
            end
        })

        vim.cmd.colorscheme 'catppuccin'
    end
}
