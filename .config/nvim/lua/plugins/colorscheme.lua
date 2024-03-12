return {
  {
    "folke/tokyonight.nvim",
    priority = 1001,
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, cl)
        hl.LineNr = { fg = cl.blue5 }
        hl.Visual = { bg = cl.blue0 }
        hl.DiagnosticUnnecessary = {
          fg = "#a1a6c4",
        }
      end,
      on_colors = function(cl)
        cl.bg_statusline = cl.none
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "frappe", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "frappe",
      },
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          LineNr = { fg = colors.subtext1 },
          Visual = { bg = colors.text, fg = colors.base },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
