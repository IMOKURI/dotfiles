return {
    -- Filetype: python
    { "Vimjas/vim-python-pep8-indent", ft = { "python" }, event = "InsertEnter" },

    {
        "roobert/f-string-toggle.nvim",
        ft = "python",
        event = "VeryLazy",
        config = function()
            require("f-string-toggle").setup({
                key_binding = "<leader>F",
            })
        end,
    },

    -- Filetype: csv
    { "mechatroner/rainbow_csv",       ft = { "csv" } },

    -- Filetype: markdown
    {
        "dhruvasagar/vim-table-mode",
        ft = { "markdown" },
        event = "VeryLazy",
        init = function()
            vim.g.table_mode_always_active = 1

            vim.keymap.set("n", "<Leader><Leader>a", "<Cmd>TableModeRealign<CR>")
        end,
    },
}
