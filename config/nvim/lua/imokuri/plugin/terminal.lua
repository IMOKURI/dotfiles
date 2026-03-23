return {
    {
        "ruicsh/termite.nvim",
        keys = {
            { "<C-t>", "<Cmd>Termite toggle<CR>", mode = { "n", "t" } },
            { "<C-g>", "<Cmd>Termite create<CR>", mode = { "n", "t" } },
            { "<C-q>", "<Cmd>Termite close<CR>", mode = { "t" } },
            { "<C-n>", "<Cmd>Termite next<CR>", mode = { "t" } },
            { "<C-p>", "<Cmd>Termite editor<CR>", mode = { "t" } },
        },
        opts = {
            position = "bottom",
            keymaps = {
                toggle = false,
                create = false,
                next = false,
                prev = false,
                focus_editor = false,
                normal_mode = false,
                maximize = false,
                close = false,
            },
            wo = { winblend = 20 },
        },
    },
}
