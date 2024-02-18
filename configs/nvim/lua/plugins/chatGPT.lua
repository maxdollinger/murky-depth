return {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
        require("chatgpt").setup()

        vim.keymap.set("n", "<leader>c", "<cmd>ChatGPT<CR>", { silent = true, desc = "opens ChatGPT" })
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim"
    }
}
