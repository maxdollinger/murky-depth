return {
  "neovim/nvim-lspconfig",
  opts = {
    -- make sure mason installs the server
    servers = {
      zls = {},
      ---@type lspconfig.options.tsserver
      ---@diagnostic disable-next-line: missing-fields
      tsserver = {
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.organizeImports.ts" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Organize Imports",
          },
          {
            "<leader>cR",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.removeUnused.ts" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Remove Unused Imports",
          },
          {
            "<leader>ci",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.addMissingImports.ts" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Add Missing Imports",
          },
        },
      },
    },
  },
}
