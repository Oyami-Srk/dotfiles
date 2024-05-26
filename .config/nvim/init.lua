function must_require(module)
    return require(module)
end

function try_require(module)
    local ok, r = pcall(require, module)
    if ok then
        return r
    else
        return nil
    end
end

if vim.g.vscode ~= nil then
    try_require("vscode")
else
    must_require("standalong")
end
must_require("global")