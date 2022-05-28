-- custom.mappings

local M = {}

M.disabled = {
  n = {
      ["<TAB>"] = "",
      ["<S-Tab>"] = "",
      ["gD"] = "",
      ["gd"] = "",
      ["gi"] = "",
      ["d["] = "",
      ["<leader>ra"] = "",
      ["<leader>ca"] = "",
      ["<leader>f"] = "",
  }
}

M.bufferline = {
   mode_opts = { silent = false }, -- this is completely optional
   n = {
      ["L"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
      ["H"] = { "<cmd> BufferLineCyclePrev <CR>", "  cycle prev buffer" },
   },
}
M.lspconfig = {
   n = {
      ["gh"] = {
         function()
            vim.lsp.buf.declaration()
         end,
         "   lsp declaration",
      },

      ["]d"] = {
         function()
            vim.diagnostic.goto_next()
         end,
         "   goto_next",
      },

      ["<leader>rn"] = {
         function()
            vim.lsp.buf.rename()
         end,
         "   lsp rename",
      },

      ["<leader>fd"] = {
         function()
            vim.diagnostic.open_float()
         end,
         "   floating diagnostic",
      },
   },
}

M.telescope = {
   n = {
      ["<C-p>"] = { "<cmd> Telescope <CR>", "   telescope buildin" },
      ["sp"] = { "<cmd> Telescope find_files <CR>", "  find files" },
      ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
      ["<leader>lg"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
      ["<leader>gs"] = { "<cmd> Telescope grep_string <CR>", "   grep string" },
      ["sb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
      ["sm"] = { "<cmd> Telescope oldfiles <CR>", "   find oldfiles" },
      ["sh"] = { "<cmd> Telescope resume<CR>", "   telescope resume" },
      ["ss"] = { "<cmd> Telescope possession list<CR>", "   possession list" },
      ["sz"] = { "<cmd> Telescope zoxide list<CR>", "   cwd list" },
      ["sf"] = { "<cmd> Telescope funky<CR>", "   funky list" },
      ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
      ["g]"] = { "<cmd> Telescope lsp_definitions path_display=tail <CR>", "   goto definition"},
      ["gw"] = { "<cmd> Telescope lsp_definitions path_display=tail jump_type=vsplit <CR>", "   goto definition vsplit"},
      ["gr"] = { "<cmd> Telescope lsp_references path_display=tail <CR>", "   goto references"},
      ["sr"] = {
        function ()
          vim.ui.input({ prompt = 'input function name:' }, function (input)
            if input then
              require('telescope.builtin').lsp_workspace_symbols({ query=input, show_line=false, ignore_filename=true, symbols='function', path_display={'hidden'}, symbol_width=100})
            end
          end)
        end,
        "  search symbols"
      },
   },
}

M.general = {
  mode_opts = { silent = true }, -- this is completely optional
  i = {
    ["<C-j>"] = { function ()
      require('luasnip').jump(1)
    end,
    " snippt down" },
    ["<C-k>"] = { function ()
      require('luasnip').jump(-1)
    end,
    " snippt up" },
  },

  n = {
    ["<leader>q"] = { "<cmd> confirm qall <CR>", "   exit vim"},
    -- ["<leader>x"] = {
    --   function ()
    --     vim.cmd("bp")
    --     vim.cmd("bd #")
    --   end,
    --   "   close buffer"
    -- },
    ["]n"] = { "<cmd> cn <CR>" , "   quickfix next"},
    ["[n"] = { "<cmd> cp <CR>" , "   quickfix prev"},
    ["J"] = { "j", "" },
    ["X"] = { '"_X', "" },
  },
  v = {
    ["J"] = { "j", "" },
  }
}

M.tasks = {
  n = {
    ["<f7>"] = {
      function () vim.cmd("wall")
        vim.cmd("message clear")
        vim.cmd("luafile %")
      end,
      "   execute luafile"
    },
    ["<f5>"] = { "<cmd> AsyncTask quick-build <CR>", "   execute luafile" },
    ["<f6>"] = { "<cmd> AsyncTask fos-tools <CR>", "   execute luafile" },
  }
}

M.gitsigns = {
  n = {
    ["]h"] = { "<cmd> Gitsigns next_hunk <CR>", "  next_hunk" },
    ["[h"] = { "<cmd> Gitsigns prev_hunk <CR>", "  prev_hunk" },
  }
}

M.vim_eft = {
  mode_opts = { silent = true, noremap = false },
  n = {
    [";"] = { "<Plug>(eft-repeat)", ""},
    ["f"] = { "<Plug>(eft-f)", ""},
    ["F"] = { "<Plug>(eft-F)", ""},
  },
  x = {
    [";"] = { "<Plug>(eft-repeat)", ""},
    ["f"] = { "<Plug>(eft-f)", ""},
    ["F"] = { "<Plug>(eft-F)", ""},
  },
  o = {
    [";"] = { "<Plug>(eft-repeat)", ""},
    ["f"] = { "<Plug>(eft-f)", ""},
    ["F"] = { "<Plug>(eft-F)", ""},
  },
}

return M
