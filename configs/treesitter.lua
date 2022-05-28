local ts_config = require("nvim-treesitter.configs")
local default = {
    ensure_installed = {
        "lua",
        "vim",
    },
    highlight = {
        enable = true,
        use_languagetree = true,
        disable = { "vim" },
    },
    matchup = {
        enable = true,              -- mandatory, false will disable the whole extension
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
            scope_incremental = '<TAB>',
        },
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["ac"] = "@comment.outer",
                ["ic"] = "@comment.outer",
                ["ai"] = "@conditional.outer",
                ["ii"] = "@conditional.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner",
                -- ["ir"] = "@call.inner",
                -- ["ar"] = "@call.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]f"] = "@function.outer",
                ["]a"] = "@parameter.outer",
                ["]i"] = "@conditional.outer",
                ["]l"] = "@loop.outer",
                ["]c"] = "@comment.outer",
                -- ["]r"] = "@call.outer",
            },
            goto_next_end = {
                ["]F"] = "@function.outer",
                ["]A"] = "@parameter.outer",
                ["]I"] = "@conditional.outer",
                ["]L"] = "@loop.outer",
                ["]C"] = "@comment.outer",
                -- ["]R"] = "@call.outer",
            },
            goto_previous_start = {
                ["[f"] = "@function.outer",
                ["[a"] = "@parameter.outer",
                ["[i"] = "@conditional.outer",
                ["[l"] = "@loop.outer",
                ["[c"] = "@comment.outer",
                -- ["[r"] = "@call.outer",
            },
            goto_previous_end = {
                ["[F"] = "@function.outer",
                ["[A"] = "@param.outer",
                ["[I"] = "@conditional.outer",
                ["[L"] = "@loop.outer",
                ["[C"] = "@comment.outer",
                -- ["[r"] = "@call.outer",
            },
        },
    }
}
ts_config.setup(default)
