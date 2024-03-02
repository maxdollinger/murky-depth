return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>e",
      function()
        local manager = require("neo-tree.sources.manager")
        local renderer = require("neo-tree.ui.renderer")
        local command = require("neo-tree.command")

        local currentBufNr = vim.api.nvim_get_current_buf()

        local state = manager.get_state("filesystem")

        if renderer.window_exists(state) then
          if state and state.bufnr and state.bufnr == currentBufNr then
            vim.api.nvim_input("<C-W>h")
          else
            command.execute({ action = "focus" })
          end
        else
          command.execute({ source = "filesystem", toggle = true })
        end
      end,
      desc = "Open or Focus Neotree",
    },
  },
  opts = {
    window = {
      position = "right",
      width = 45,
    },
  },
}
