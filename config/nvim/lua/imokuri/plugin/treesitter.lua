return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-refactor",
            "p00f/nvim-ts-rainbow",
        },
        event = "BufRead",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "dockerfile",
                    "json",
                    "lua",
                    "make",
                    "python",
                    "yaml",
                },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = false,
                },
                refactor = {
                    highlight_definitions = {
                        enable = true,
                    },
                    highlight_current_scope = {
                        enable = false,
                    },
                },
                rainbow = {
                    enable = true,
                    disable = { "bash" },
                },
            })

        end,
    },

}
