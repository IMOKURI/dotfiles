return {
    -- Filetype: python
    { "Vimjas/vim-python-pep8-indent", ft = { "python" }, event = "InsertEnter" },

    {
        "roobert/f-string-toggle.nvim",
        ft = "python",
        event = "VeryLazy",
        opts = { key_binding = "<leader>F" },
    },

    -- Filetype: csv
    { "mechatroner/rainbow_csv", ft = { "csv" } },

    -- Filetype: markdown
    {
        "dhruvasagar/vim-table-mode",
        ft = { "markdown" },
        event = "VeryLazy",
        init = function()
            vim.g.table_mode_always_active = 1
            vim.keymap.set("n", "<Leader>A", "<Cmd>TableModeRealign<CR>")
        end,
    },
}
