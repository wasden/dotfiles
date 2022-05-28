local M = {}

M.setup_lsp = function(_, capabilities)
   local lspconfig = require "lspconfig"

   local function attach_basic_map(_, bufnr)
     local options = require("plugins.configs.whichkey").options
     local lsp_mappings = { nvchad.load_config().mappings.lspconfig }

     lsp_mappings[1]["mode_opts"] = { buffer = bufnr }

     if not nvchad.whichKey_map(lsp_mappings, options) then
       nvchad.no_WhichKey_map(lsp_mappings)
     end
   end

   local function attach_map_with_format(_, _)
     attach_basic_map(_, _)
     vim.keymap.set("v", "=",
     function ()
       local old_func = vim.go.operatorfunc
       _G.op_func_formatting = function()
         local start = vim.api.nvim_buf_get_mark(0, '[')
         local finish = vim.api.nvim_buf_get_mark(0, ']')
         vim.lsp.buf.range_formatting({}, start, finish)
         vim.go.operatorfunc = old_func
         _G.op_func_formatting = nil
       end
       vim.go.operatorfunc = 'v:lua.op_func_formatting'
       vim.api.nvim_feedkeys('g@', 'n', false)
     end,
     {buffer=0})
   end

   lspconfig.ccls.setup {
       on_attach = attach_map_with_format,
       capabilities = capabilities,
       flags = {
           debounce_text_changes = 150,
       },
       init_options = {
           cache = {
               directory = "/home/huang/.ccls-cache";
           };
       }
   }
   lspconfig.sumneko_lua.setup {
       on_attach = attach_basic_map,
       capabilities = capabilities,
       flags = {
           debounce_text_changes = 150,
       },
       settings = {
         enable = true,
         -- Put format options here
         -- NOTE: the value should be STRING!!
         defaultConfig = {
           indent_style = "space",
           indent_size = "2",
         },
         Lua = {
           diagnostics = {
             globals = { 'vim' }
           },
           workspace = {
             library = {
               [vim.fn.expand "$VIMRUNTIME/lua"] = true,
               [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
             },
             maxPreload = 100000,
             preloadFileSize = 10000,
           },
         }
       }

   }
end

return M
