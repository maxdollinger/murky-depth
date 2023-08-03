return {
  'lukas-reineke/indent-blankline.nvim',
  -- See `:help indent_blankline.txt`
  config = function()
    vim.cmd [[highlight IndentBlanklineContextChar guifg=#999999 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineChar guifg=#666666 gui=nocombine]]

    require('indent_blankline').setup({
      char = '┊',
      show_trailing_blankline_indent = false,
      show_current_context = true,
      use_treesitter = true,
      use_treesitter_scope = true
    })
  end
}
