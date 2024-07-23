local configurator = {
    ranger = function()
        require("ranger-nvim").setup({ replace_netrw = true })
    end
}

return {
    -- Fuzzy finder for file/buffer/tag...
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = true
    },
    -- Ranger, Tree style file explorer
    -- REQUIRE: ranger
    -- {
    -- 'kelly-lin/ranger.nvim',
    -- config = configurator.ranger,
    -- lazy = true
    -- },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim"
        },
        lazy = true
    },
}
