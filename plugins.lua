return {

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "custom.configs.lspconfig"
    end,
  },

  -- ["SmiteshP/nvim-gps"] = {
  --     after = "nvim-treesitter",
  --     config = function()
  --       require("nvim-gps").setup({
  --         disable_icons = true
  --       })
  --     end
  -- },

  -- textobj增強
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = "nvim-treesitter",
    config = function()
      require 'nvim-treesitter.configs'.setup(require("custom.configs.textobjs"))
    end
  },

  -- 平滑滚动
  ["karb94/neoscroll.nvim"] = {
    config = function()
      require('neoscroll').setup({
        hide_cursor = false, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = true, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = true, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = true, -- Disable "Performance Mode" on all buffers.
      })
    end,
  },

  -- 增删改引号
  -- ["ur4ltz/surround.nvim"] = {
  --   config = function()
  --     require"surround".setup {mappings_style = "surround"}
  --   end
  -- },

  -- 现代任务系统
  ["skywind3000/asyncrun.vim"] = {
    cmd = { "AsyncRun" },
  },
  ["skywind3000/asynctasks.vim"] = {
    -- after = "asyncrun.vim",
    cmd = { "AsyncTask", "AsyncTaskEdit", "AsyncTaskList" },
    config = function()
      -- asynctasks设置
      vim.g.asyncrun_open = 6
      vim.g.asynctasks_term_pos = "right"
      vim.g.asynctasks_term_focus = 0
    end
  },

  -- telescope加速
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    run = 'make',
    after = "telescope.nvim",
    config = function()
      require('telescope').load_extension('fzf')
    end
  },

  -- 行内查找
  ['hrsh7th/vim-eft'] = {
  },

  -- session管理
  ['wasden/possession.nvim'] = {
    config = function()
      require('possession').setup {
        silent = true,
        prompt_no_cr = true,
        autosave = {
          current = true, -- or fun(name): boolean
          tmp = true, -- or fun(): boolean
          tmp_name = 'tmp',
          on_load = true,
          on_quit = true,
        },
        commands = {
          save = 'SSave',
          load = 'SLoad',
          delete = 'SDelete',
          list = 'SList',
        },
        plugins = {
          close_windows = false,
          delete_hidden_buffers = false,
          nvim_tree = false,
          tabby = false,
          delete_buffers = true,
          in_session_buffers_only = true,
        },
      }
    end
  },

  -- 启动页面
  ['goolord/alpha-nvim'] = {
    disable = false,
    config = function()
      require "custom.configs.startup_screen"
    end
  },

  -- 函数大纲
  ['wasden/telescope-funky.nvim'] = {
    after = "telescope.nvim",
    config = function() -- need compile after change
      require('telescope').load_extension('funky')
      require('funky').setup {
        c = {
          {
            regex = '^#if FOS_PART%("(.*)"%)',
            sortable = true,
            selectable = false,
          },
          {
            sortable = true,
            selectable = true,
            treesitter_kind = "function",
          }
        },
        cpp = {
          {
            regex = '^#if FOS_PART%("(.*)"%)',
            sortable = true,
            selectable = false,
          },
          {
            sortable = true,
            selectable = true,
            treesitter_kind = "function|type|macro",
          }
        },
      }
    end
  },

  ['wasden/cmp-flypy.nvim'] = {
    run = 'make',
    after = "nvim-cmp",
    config = function() -- 配置config以修改默认配置
      require("flypy").setup({
        space_select_enable = true
      })
    end
  },

  ['wasden/source_highlight.nvim'] = {
    keys = { "<F8>", "<F9>", "<S-F8>" },
    config = function()
      require("source_highlight").setup()
    end
  },
  ['jvgrootveld/telescope-zoxide'] = {
    after = "telescope.nvim",
    config = function()
      require 'telescope'.load_extension('zoxide')
      require("telescope._extensions.zoxide.config").setup({
        mappings = {
          default = {
            keepinsert = true,
            after_action = function(selection)
              require('telescope.builtin').find_files({ cwd = selection.path })
            end
          },
        }
      })
    end
  },

  ['jakewvincent/mkdnflow.nvim'] = {
    rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
    ft = "markdown",
    module = "mkdnflow",
    config = function()
      require('mkdnflow').setup({})
    end
  },
  ['lukas-reineke/headlines.nvim'] = {
    after = "nvim-treesitter",
    config = function()
      require('custom.colors').setup()
      require('headlines').setup {
        markdown = {
          headline_highlights = { 'markdownH1', 'markdownH2', 'markdownH3', 'markdownH4', 'markdownH5', 'markdownH6' },
          -- codeblock_highlight = "markdownCodeBlock",
          dash_highlight = "markdownBold",
          quote_highlight = "markdownBlockquote",
          fat_headline_upper_string = "▃",
        }
      }
    end,
  },


  ["hrsh7th/nvim-cmp"] = {
    override_options = function()
      local cmp = require "cmp"
      return {
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
          {
            name = "flypy", }
        },
        mapping = {
          ["<CR>"] = cmp.mapping.confirm {
            select = true,
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s", }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s", }),
        },
      }
    end
  },

  ["NvChad/ui"] = {
    override_options = {
      statusline = {
        separator_style = "round",
        -- overriden_modules = function()
        --   return require "custom.abc"
        -- end,
      },
    },
  },

  -- ["nvim-treesitter/nvim-treesitter"] = {
  --   event = { "BufRead", "BufNewFile" },
  --   run = "",
  --   override_options = require "custom.configs.treesitter"
  -- },
  ["folke/which-key.nvim"] = {
    disable = false,
  },
  --
  ['sindrets/diffview.nvim'] = {
    disable = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" }
  },
  ["kylechui/nvim-surround"] = {
    keys = {
      { "n", "ds" },
      { "n", "ys" },
      { "n", "cs" },
      { "v", "S" },
      { "i", "<C-g>" },
    },
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  ["dnlhc/glance.nvim"] = {
    cmd = {"Glance"},
    config = function()
      require('glance').setup({
        theme = { -- This feature might not work properly in nvim-0.7.2
          enable = false, -- Will generate colors for the plugin based on your current colorscheme
          mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        }, -- your configuration
      })
    end,
  },

  ['NvChad/nvim-colorizer.lua'] = false,
  ['kyazdani42/nvim-tree.lua'] = false,
  ['williamboman/mason.nvim'] = false,
}
