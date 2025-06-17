return {
    {
        "nvzone/floaterm",
        dependencies = "nvzone/volt",
        keys = {
            { "<C-t>", "<Cmd>FloatermToggle<CR>", mode = "n" },
            { "<C-t>", "<C-\\><C-n><Cmd>FloatermToggle<CR>", mode = "t" },
        },
        opts = {
            border = true,
            size = { h = 60, w = 80 },
        },
    },
}
