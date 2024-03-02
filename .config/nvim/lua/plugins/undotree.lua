return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle | UndotreeFocus <cr>")
    vim.g.undotree_SplitWidth = 40
    vim.g.undotree_WindowLayout = 2
  end,
}
