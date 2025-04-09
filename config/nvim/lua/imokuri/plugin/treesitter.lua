return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-refactor",
        },
        event = "BufRead",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "astro",
                    "bash",
                    "css",
                    "dockerfile",
                    "json",
                    "lua",
                    "make",
                    "python",
                    "regex",
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
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "+",
                        node_incremental = "+",
                        node_decremental = "-",
                    },
                },
            })
        end,
    },
}
