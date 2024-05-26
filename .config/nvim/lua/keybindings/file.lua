--[[
    "f": {
        "name": "+file",
        "f": [":Leaderf file", "open-file"],
        "w": [":w", "write-file"],
        "e": [":e ~/.config/nvim/init.vim", "open-config"],
        "t": [":NERDTreeToggle", "goto-type-definition"],
        "r": [":Ranger", "ranger"]
    },
]]

return {
    key = 'f',
    opts = {
        name = "+file",
        f = { function() require('telescope.builtin').find_files() end, "Open File" },
        w = { ":w", "Write File" },
        r = { function() require('ranger-nvim').open(true) end, "Ranger" },
        t = { function() require('neo-tree')() end, "NeoTree" }
    }
}
