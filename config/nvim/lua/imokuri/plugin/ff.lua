return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "IMOKURI/apyrori.nvim",
            "mattn/vim-sonictemplate",
            "natecraddock/telescope-zf-native.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-tree/nvim-web-devicons",
            "rcarriga/nvim-notify",
            "smartpde/telescope-recent-files",
            "stevearc/overseer.nvim",
            "tamago324/telescope-sonictemplate.nvim",
        },
        keys = {
            { "<Leader>D", "<Cmd>lua require('telescope.builtin').diagnostics({})<CR>" },
            {
                "<Leader>E",
                "<Cmd>lua require('telescope.builtin').symbols({ sources = {'emoji', 'gitmoji', 'nerd', 'math'} })<CR>",
            },
            { "<Leader>[", "<Cmd>lua require('telescope.builtin').lsp_references()<CR>" },
            { "<Leader>]", "<Cmd>lua require('telescope.builtin').lsp_definitions()<CR>" },
            { "<Leader>b", "<Cmd>lua require('telescope.builtin').buffers()<CR>" },
            { "<Leader>d", "<Cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>" },
            { "<Leader>e", "<Cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>" },
            { "<Leader>f", "<Cmd>lua TelescopeProjectFiles()<CR>" },
            { "<Leader>g", "<Cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>" },
            { "<Leader>i", "<Cmd>Telescope apyrori<CR>" },
            { "<Leader>o", "<Cmd>lua require('telescope').extensions.recent_files.pick()<CR>" },
            { "<Leader>s", "<Cmd>lua require('telescope').extensions.sonictemplate.templates{}<CR>" },
            {
                "<Leader>t",
                function()
                    vim.cmd("OverseerRun")
                    vim.cmd("OverseerOpen!")
                end,
            },
            { "<C-t>", "<Cmd>OverseerToggle<CR>" },
        },
        init = function()
            vim.g.sonictemplate_vim_template_dir = { string.format("%s/template", vim.fn.stdpath("config")) }
        end,
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
                    path_display = {
                        filename_first = {
                            reverse_directories = true,
                        },
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

            local overseer = require("overseer")
            overseer.setup({
                task_list = {
                    max_height = { 30, 0.2 },
                    min_height = 20,
                },
            })
            overseer.register_template({
                 name = "docker ps",
                 builder = function()
                     return {
                         name = "docker ps --latest",
                         cmd = { "docker" },
                         args = { "ps", "--latest" },
                     }
                 end
            })
        end,
    },
}
