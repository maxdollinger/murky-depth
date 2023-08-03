return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
        options = {
            icons_enabled = true,
            theme = 'catppuccin',
            component_separators = '|',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                'mode',
            },
            lualine_b = { 'branch', 'diagnostics' },
            lualine_c = { { 'filename', path = 1 } },
            lualine_x = {},
            lualine_y = { 'fileformat', 'filetype', 'encoding' },
            lualine_z = { 'progress', 'location' },
        }
    },
}
