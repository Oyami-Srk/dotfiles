-- Load options for Neovim built-in features.
Must_require("built-in-options")

-- Initial lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
local function load_plugins()
    local spec = {
        { import = "plugins/common" }
    }
    if vim.g.vscode ~= nil then
        spec[#spec + 1] = { import = "plugins/vscode" }
    else
        spec[#spec + 1] = { import = "plugins/standalong" }
    end

    require("lazy").setup(spec)
end

load_plugins()
