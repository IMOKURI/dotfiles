return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        config = function() require("nvim-treesitter").install(require("imokuri.util").treesitter_filetypes) end,
    },
}
