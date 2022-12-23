return {
    -- Terminal
    {
        "kassio/neoterm",
        keys = {
            "<C-t>",
            "<C-g>",
        },
        config = function()
            vim.g.neoterm_autoscroll = 1
            vim.g.neoterm_default_mod = "botright"
            vim.g.neoterm_repl_python = "python"
            vim.g.neoterm_automap_keys = ""

            vim.keymap.set("n", "<C-t>", "<Cmd>Ttoggle<CR>")
            vim.keymap.set("t", "<C-t>", "<C-\\><C-n><Cmd>Ttoggle<CR>")

            vim.keymap.set("n", "<C-g>", "<Cmd>Topen<CR><C-w>bi")
            vim.keymap.set("t", "<C-g>", "<C-\\><C-n><C-w>p")
        end,
    },
}
