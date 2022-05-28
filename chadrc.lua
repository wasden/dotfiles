local M = {}

M.options = {
  user = function ()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.undofile = false
    vim.opt.mouse = "a"
    vim.opt.efm = "%f:%l:%c: error: %m"
    vim.opt.laststatus = 2
    vim.opt.scrolloff = 999
    vim.opt.guifont="Inconsolata:h13"
    vim.opt.ignorecase = false
   end,
}

M.ui = {
   -- theme = "gruvchad",
   theme = "onedark",
}

local userPlugins = require "custom.plugins"
local cmp = require("cmp")

M.plugins = {
  user = userPlugins,
   options = {
      lspconfig = {
         setup_lspconf = "custom.configs.lspconfig",
      },
      telescope = {
         extensions = { "themes", "terms" }
      }
   },
   override = {
     ["ray-x/lsp_signature.nvim"] = {
       floating_window_above_cur_line = false,
     },
     ["hrsh7th/nvim-cmp"] = {
       sources = {
         { name = "nvim_lsp" },
         { name = "luasnip" },
         { name = "buffer" },
         { name = "nvim_lua" },
         { name = "path" },
         {
           name = "flypy",}
       },
       mapping = {
         ["<CR>"] = cmp.mapping.confirm {
           behavior = cmp.ConfirmBehavior.Insert,
           select = true,
         },
         ["<Space>"] = cmp.mapping(function(fallback)
           if cmp.visible() then
             local selected_entry = cmp.core.view:get_selected_entry()
             if not selected_entry then
               return fallback()
             end
             if selected_entry.source.name == "flypy" and not cmp.confirm({select=true}) then
               return fallback()
             end
           else
             fallback()
           end
         end,
         {"i","s",}),
         ["<Tab>"] = cmp.mapping(function(fallback)
           if cmp.visible() then
             cmp.select_next_item()
           else
             fallback()
           end
         end, {"i","s",}),
         ["<S-Tab>"] = cmp.mapping(function(fallback)
           if cmp.visible() then
             cmp.select_prev_item()
           else
             fallback()
           end
         end, {"i","s",}),
       },
     },
   },
   remove = {
     "NvChad/nvim-colorizer.lua",
     "max397574/better-escape.nvim",
     -- "andymass/vim-matchup",
     "kyazdani42/nvim-tree.lua",
     -- "williamboman/nvim-lsp-installer",
   }
}


-- non plugin
M.mappings = require("custom.map")

return M
