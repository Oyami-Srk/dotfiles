function Must_require(module)
    return require(module)
end

function Try_require(module)
    local ok, r = pcall(require, module)
    if ok then
        return r
    else
        return nil
    end
end

if vim.g.vscode ~= nil then
    Try_require("vscode")
else
    Must_require("standalong")
end
Must_require("global")