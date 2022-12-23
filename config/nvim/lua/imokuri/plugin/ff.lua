return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "IMOKURI/apyrori.nvim",
            "kyazdani42/nvim-web-devicons",
            "mattn/vim-sonictemplate",
            "natecraddock/telescope-zf-native.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "nvim-telescope/telescope-smart-history.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "rcarriga/nvim-notify",
            "smartpde/telescope-recent-files",
            "tamago324/telescope-sonictemplate.nvim",
            "tami5/sqlite.lua",
        },
        keys = {
            "<Leader>D",
            "<Leader>E",
            "<Leader>[",
            "<Leader>]",
            "<Leader>b",
            "<Leader>d",
            "<Leader>e",
            "<Leader>f",
            "<Leader>g",
            "<Leader>i",
            "<Leader>o",
            "<Leader>s",
        },
        init = function() vim.g.sonictemplate_vim_template_dir = { string.format("%s/template", vim.fn.stdpath("config")) } end,
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local action_layout = require("telescope.actions.layout")

            function TelescopeProjectFiles(opts)
                opts = opts or {}
                opts.show_untracked = true
                if vim.loop.fs_stat(".git") then
                    require("telescope.builtin").git_files(opts)
                else
                    local client = vim.lsp.get_active_clients()[1]
                    if client then
                        opts.cwd = client.config.root_dir
                    end
                    require("telescope.builtin").find_files(opts)
                end
            end

            vim.keymap.set("n", "<Leader>D", "<Cmd>lua require('telescope.builtin').diagnostics({})<CR>")
            vim.keymap.set(
                "n",
                "<Leader>E",
                "<Cmd>lua require('telescope.builtin').symbols({ sources = {'emoji', 'gitmoji', 'nerd', 'math'} })<CR>"
            )
            vim.keymap.set("n", "<Leader>[", "<Cmd>lua require('telescope.builtin').lsp_references()<CR>")
            vim.keymap.set("n", "<Leader>]", "<Cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
            vim.keymap.set("n", "<Leader>b", "<Cmd>lua require('telescope.builtin').buffers()<CR>")
            vim.keymap.set("n", "<Leader>d", "<Cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>")
            vim.keymap.set("n", "<Leader>e", "<Cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>")
            vim.keymap.set("n", "<Leader>f", "<Cmd>lua TelescopeProjectFiles()<CR>")
            vim.keymap.set(
                "n",
                "<Leader>g",
                "<Cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"
            )
            vim.keymap.set("n", "<Leader>i", "<Cmd>Telescope apyrori<CR>")
            vim.keymap.set("n", "<Leader>o", "<Cmd>lua require('telescope').extensions.recent_files.pick()<CR>")
            vim.keymap.set("n", "<Leader>s", "<Cmd>lua require('telescope').extensions.sonictemplate.templates{}<CR>")

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
                    history = {
                        path = string.format("%s/telescope_history.sqlite3", vim.fn.stdpath("data")),
                        limit = 100,
                    },
                },
                extensions = {
                    live_grep_args = {
                        default_mappings = {},
                        mappings = {
                            i = {
                                ["<C-o>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                            },
                        },
                    },
                    recent_files = {
                        ignore_patterns = {
                            ".git/",
                        },
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            telescope.load_extension("apyrori")
            telescope.load_extension("file_browser")
            telescope.load_extension("live_grep_args")
            telescope.load_extension("notify")
            telescope.load_extension("recent_files")
            telescope.load_extension("smart_history")
            telescope.load_extension("sonictemplate")
            telescope.load_extension("ui-select")
            telescope.load_extension("zf-native")

            require("apyrori").setup({
                choose_most_likely = false,

                default_imports = {
                    "import numpy as np",
                    "import pandas as pd",
                },
            })
        end,
    },
}
