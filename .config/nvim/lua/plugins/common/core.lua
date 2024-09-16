local initial_keybindings = {
    -- File
    { "<leader>f",  group = "file" },
    { "<leader>fw", ":w",                         desc = "Write File" },
    { "<leader>fe", ":e ~/.config/nvim/init.vim", desc = "Open Config" },
}

return {
    -- Plugin Manager
    { "folke/lazy.nvim", tag = "stable" },
    -- Keybinding Manager
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = initial_keybindings,
        dependencies = {
            "echasnovski/mini.icons",
        }
    },
    -- Easymotion
    {
        "easymotion/vim-easymotion",
        event = "VeryLazy",
        config = function()
            vim.g.EasyMotion_do_mapping = 0
            vim.g.EasyMotion_smartcase = 1
            vim.g.EasyMotion_use_smartsign_us = 1
            vim.g.EasyMotion_startofline = 0
        end
    },
}
