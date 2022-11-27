vim.cmd [[ au TextYankPost * silent! lua vim.highlight.on_yank() ]]
-- Open a file from its last left off position
vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
vim.cmd [[ au FileType lua setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab ]]

-- vim.cmd [[ au FileType * lua vim.notify = require("notify") ]]
