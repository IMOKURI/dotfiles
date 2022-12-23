return {
    -- Filetype: python
    { "Vimjas/vim-python-pep8-indent", ft = { "python" } },

    -- Filetype: csv
    { "mechatroner/rainbow_csv", ft = { "csv" } },

    -- Filetype: markdown
    {
        "dhruvasagar/vim-table-mode",
        ft = { "markdown" },
        init = function()
            vim.g.table_mode_always_active = 1

            vim.keymap.set("n", "<Leader><Leader>a", "<Cmd>TableModeRealign<CR>")
        end,
    },
}
