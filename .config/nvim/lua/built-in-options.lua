-- Backup Files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true

-- UI
vim.o.cmdheight = 1
vim.o.updatetime = 300
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.list = true
vim.o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- vim.o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
vim.o.smoothscroll = true

-- Line number
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "number"

-- Indent
-- vim.o.autoindent = true
-- vim.o.smartindent = true
vim.o.cindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.backspace = "indent,eol,start"

-- Color
vim.o.t_Co = 256
vim.o.termguicolors = true

-- Language
vim.o.langmenu = "en_US"
vim.o.fileencodings = "utf-8,gbk,ucs-bom,shift-jis,gb18030,cp936"
vim.o.fileencoding = "utf-8"
vim.o.termencoding = "utf-8"

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- Mouse
vim.o.mouse = 'a'

-- Clipboard
vim.o.clipboard = 'unnamedplus'

-- Sequence Keymapping
vim.o.timeout = true
vim.o.timeoutlen = 300 -- wait 300ms for next key stroke

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
