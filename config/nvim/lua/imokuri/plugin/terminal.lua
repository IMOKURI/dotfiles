return {
    {
        "kassio/neoterm",
        keys = {
            { "<C-t>", "<Cmd>Ttoggle<CR>", mode = "n" },
            { "<C-t>", "<C-\\><C-n><Cmd>Ttoggle<CR>", mode = "t" },
            { "<C-g>", "<Cmd>Topen<CR><C-w>bi", mode = "n" },
            { "<C-g>", "<C-\\><C-n><C-w>p", mode = "t" },
        },
        config = function()
            vim.g.neoterm_size = 20
            vim.g.neoterm_autoscroll = 1
            vim.g.neoterm_default_mod = "botright"
            vim.g.neoterm_repl_python = "python"
            vim.g.neoterm_automap_keys = ""
        end,
    },
}
