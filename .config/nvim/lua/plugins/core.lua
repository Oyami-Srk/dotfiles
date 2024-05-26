local configurator = {
    which_key = function()
        local wk = require('which-key');
        wk.setup()

        local keymaps = {}
        for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/keybindings', [[v:val =~ '\.lua$']])) do
            local keybinding = require('keybindings.' .. file:gsub('%.lua$', ''))
            if keybinding ~= nil then
                keymaps[keybinding.key] = keybinding.opts
            end
        end
        wk.register(keymaps, { prefix = "<leader>" })
    end,
}

return {
    -- Plugin Manager
    { "folke/lazy.nvim", tag = "stable" },
    -- Keybinding Manager
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = configurator.which_key
    }
}
