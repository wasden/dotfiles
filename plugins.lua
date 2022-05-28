return {
   ["feline-nvim/feline.nvim"] = {
      after = "nvim-web-devicons",
      config = function()
         require "custom.configs.statusline"
      end,
   },
   ["lewis6991/impatient.nvim"] = {
     commit = '2337df7d778e17a58d8709f651653b9039946d8d'
   },

   ["nvim-treesitter/nvim-treesitter"] = {
      event = { "BufRead", "BufNewFile" },
      -- run = ":TSUpdate",
      config = function()
         require "custom.configs.treesitter"
      end,
   },

  ["SmiteshP/nvim-gps"] = {
      after = "nvim-treesitter",
      config = function()
        require("nvim-gps").setup({
          disable_icons = true
        })
      end
  },

  -- textobj增強
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
      after = "nvim-treesitter",
  },

  -- 平滑滚动
  ["karb94/neoscroll.nvim"] = {
    config = function()
      require('neoscroll').setup({
        hide_cursor = false,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = true, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = true,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
        performance_mode = true,    -- Disable "Performance Mode" on all buffers.
      })
    end,
  },

  -- 增删改引号
  ["ur4ltz/surround.nvim"] = {
    config = function()
      require"surround".setup {mappings_style = "surround"}
    end
  },

  -- 现代任务系统
  ["skywind3000/asynctasks.vim"] = {
    requires = "skywind3000/asyncrun.vim",
    cmd = {"AsyncTask", "AsyncTaskEdit"},
    config = function ()
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
  ['hrsh7th/vim-eft'] = {},

  -- session管理
  ['wasden/possession.nvim'] = {
    config = function ()
      require('possession').setup {
        silent = false,
        prompt_no_cr = true,
        autosave = {
          current = true,  -- or fun(name): boolean
          tmp = true,  -- or fun(): boolean
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
    config = function ()
      require "custom.configs.startup_screen"
    end
  },

  -- 函数大纲
  ['wasden/telescope-funky.nvim'] = {
    after = "telescope.nvim",
    config = function () -- need compile after change
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
  },

  ['wasden/ExpandStar.nvim'] = {
    config = function ()
      require("expandstar").setup()
    end
  },
  ['jvgrootveld/telescope-zoxide'] = {
    after = "telescope.nvim",
    config = function ()
      require'telescope'.load_extension('zoxide')
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
  ['rcarriga/nvim-notify'] = {
  },

}
