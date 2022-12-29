return {
    -- Comment
    {
        "numToStr/Comment.nvim",
        keys = {
            { "<Leader>c", "gcc", remap = true },
            { "<Leader>c", "gc", mode = "x", remap = true },
        },
        config = true,
    },

    -- Sandwich
    {
        "machakann/vim-sandwich",
        event = { "BufRead", "BufNewFile" },
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
        event = { "BufRead", "BufNewFile" },
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
}
