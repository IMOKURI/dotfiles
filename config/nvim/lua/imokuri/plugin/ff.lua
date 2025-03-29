return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "mattn/vim-sonictemplate",
            "tamago324/telescope-sonictemplate.nvim",
        },
        keys = {
            { "<Leader>s", "<Cmd>lua require('telescope').extensions.sonictemplate.templates{}<CR>" },
        },
        init = function()
            vim.g.sonictemplate_vim_template_dir = { string.format("%s/template", vim.fn.stdpath("config")) }
        end,
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local action_layout = require("telescope.actions.layout")

            telescope.setup({
                defaults = {
                    layout_strategy = "flex",
                    mappings = {
                        i = {
                            ["<Esc>"] = actions.close,
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<Tab>"] = action_layout.toggle_preview,
                        },
                    },
                },
            })

            telescope.load_extension("sonictemplate")
        end,
    },
}
