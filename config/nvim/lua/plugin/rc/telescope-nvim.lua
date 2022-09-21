local M = {}
local telescope = require("telescope")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

function M.config()
    vim.keymap.set("n", "<Leader>b", "<Cmd>lua require('telescope.builtin').buffers()<CR>")
    vim.keymap.set("n", "<Leader>d", "<Cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>")
    vim.keymap.set("n", "<Leader>D", "<Cmd>lua require('telescope.builtin').diagnostics({})<CR>")
    vim.keymap.set("n", "<Leader>f", "<Cmd>lua require('plugin.rc.telescope-nvim').project_files()<CR>")
    vim.keymap.set("n", "<Leader>g", "<Cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
    vim.keymap.set(
        "n",
        "<Leader>E",
        "<Cmd>lua require('telescope.builtin').symbols({ sources = {'emoji', 'gitmoji', 'nerd', 'math'} })<CR>"
    )
    vim.keymap.set("n", "<Leader>]", "<Cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
    vim.keymap.set("n", "<Leader>[", "<Cmd>lua require('telescope.builtin').lsp_references()<CR>")

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
                        ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt(),
                    }
                }
            },
            recent_files = {
                ignore_patterns = {
                    "/tmp/",
                    ".git/",
                },
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
        },
    })

    telescope.load_extension("live_grep_args")
    telescope.load_extension("notify")
    telescope.load_extension("smart_history")
    telescope.load_extension("ui-select")
end

function M.project_files()
    local opts = {}
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then
        require("telescope.builtin").find_files(opts)
    end
end

function M.zf_native()
    telescope.load_extension("zf-native")
end

function M.recent_files()
    vim.keymap.set("n", "<Leader>o", "<Cmd>lua require('telescope').extensions.recent_files.pick()<CR>")

    telescope.load_extension("recent_files")
end

function M.sonictemplate()
    vim.keymap.set("n", "<Leader>s", "<Cmd>lua require('telescope').extensions.sonictemplate.templates{}<CR>")

    telescope.load_extension("sonictemplate")
end

function M.apyrori()
    vim.keymap.set("n", "<Leader>i", "<Cmd>Telescope apyrori<CR>")

    telescope.load_extension("apyrori")

    require("apyrori").setup({
        choose_most_likely = false,

        default_imports = {
            "import numpy as np",
            "import pandas as pd",
        },
    })
end

return M
