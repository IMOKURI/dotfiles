return {
    -- Comment
    {
        "numToStr/Comment.nvim",
        keys = "<Leader>c",
        config = function()
            require("Comment").setup()

            vim.keymap.set("n", "<Leader>c", "gcc", { remap = true })
            vim.keymap.set("x", "<Leader>c", "gc", { remap = true })
        end,
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
        config = function() vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(operator-replace)") end,
    },

    -- Text Objects
    {
        "kana/vim-textobj-line",
        dependencies = {
            "kana/vim-textobj-user",
        },
    },

    -- Clever-f
    {
        "rhysd/clever-f.vim",
        event = { "BufRead", "BufNewFile" },
    },

    -- Suda
    {
        "lambdalisue/suda.vim",
        init = function() vim.g.suda_smart_edit = 1 end,
    },
}
