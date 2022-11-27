local opt = vim.opt
local g = vim.g
local config = require("core.utils").load_config()
opt.shiftwidth = 4
opt.tabstop = 4
opt.undofile = false
opt.mouse = "a"
opt.efm = "%f:%l:%c: error: %m"
opt.laststatus = 2
opt.scrolloff = 999
opt.guifont="Inconsolata:h13"
-- opt.guifont="Inconsolata"
opt.ignorecase = false
opt.cmdheight = 0
-- opt.cindent = true

-- if vim.fun.exists("g:neovide") then
--   -- Put anything you want to happen only in Neovide here
--   g.neovide_hide_mouse_when_typing = true
--   g.neovide_fullscreen = true
-- end
