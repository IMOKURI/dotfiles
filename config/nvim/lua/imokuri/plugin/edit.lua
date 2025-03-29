return {
    -- Comment
    {
        "folke/ts-comments.nvim",
        keys = {
            { "<Leader>c", "gcc", remap = true },
            { "<Leader>c", "gc", mode = "x", remap = true },
        },
    },

    -- Sandwich
    {
        "machakann/vim-sandwich",
        event = "VeryLazy",
        init = function() vim.keymap.set({ "n", "x" }, "s", "<Nop>") end,
    },

    -- Operator
    {
        "kana/vim-operator-replace",
        dependencies = {
            "kana/vim-operator-user",
        },
        keys = {
            { "S", "<Plug>(operator-replace)", mode = { "n", "x", "o" } },
        },
    },

    -- Text Objects
    {
        "kana/vim-textobj-line",
        dependencies = {
            "kana/vim-textobj-user",
        },
        event = "VeryLazy",
    },

    -- Clever-f
    {
        "rhysd/clever-f.vim",
        keys = "f",
    },

    -- Suda
    {
        "lambdalisue/suda.vim",
        init = function() vim.g.suda_smart_edit = 1 end,
    },

    -- Oil
    {
        "stevearc/oil.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "-", "<Cmd>Oil<CR>", mode = "n" },
        },
        opts = {},
    },

    -- LineDiff
    {
        "AndrewRadev/linediff.vim",
        cmd = "Linediff",
    },

    -- Auto Indent
    {
        "vidocqh/auto-indent.nvim",
        event = "InsertEnter",
    },
}
