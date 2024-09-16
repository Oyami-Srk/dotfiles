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
        lazy = true,
        keys = {
            { "<leader>ff", function() require('telescope.builtin').find_files() end, desc = "Open File" },
        }
    },
    -- Ranger, Tree style file explorer
    -- REQUIRE: ranger
    -- {
    -- 'kelly-lin/ranger.nvim',
    -- config = configurator.ranger,
    -- lazy = true,
    -- keys = {
    --     { "<leader>fr", function() require('ranger-nvim').open(true) end, desc = "Ranger" },
    -- }
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
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                }
            }
        },
        lazy = true,
        keys = {
            { "<leader>ft", ":Neotree<CR>" },
        }
    },
}
