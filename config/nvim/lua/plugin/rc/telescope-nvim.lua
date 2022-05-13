local M = {}
local telescope = require("telescope")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

function M.config()
    vim.keymap.set("n", "<Leader>d", "<Cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>")
    vim.keymap.set("n", "<Leader>D", "<Cmd>lua require('telescope.builtin').diagnostics({})<CR>")
    vim.keymap.set("n", "<Leader>f", "<Cmd>lua require('plugin.rc.telescope-nvim').project_files()<CR>")
    vim.keymap.set("n", "<Leader>g", "<Cmd>lua require('telescope.builtin').live_grep()<CR>")
    vim.keymap.set(
        "n",
        "<Leader>e",
        "<Cmd>lua require('telescope.builtin').symbols({ sources = {'emoji', 'gitmoji'} })<CR>"
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
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
        },
    })

    telescope.load_extension("ui-select")
    telescope.load_extension("smart_history")
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

function M.sonictemplate()
    vim.keymap.set("n", "<Leader>s", "<Cmd>lua require('telescope').extensions.sonictemplate.templates{}<CR>")

    telescope.load_extension("sonictemplate")
end

return M
