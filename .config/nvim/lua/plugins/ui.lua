local configurator = {
    lualine = function()
        require('lualine').setup()
    end,
}

return {
    -- Status Line.
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        config = configurator.lualine,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }
}
