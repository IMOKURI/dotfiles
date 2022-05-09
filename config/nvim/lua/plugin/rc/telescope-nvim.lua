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
                    ["<Tab>"] = action_layout.toggle_preview,
                },
            },
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({
                    -- even more opts
                }),

                -- pseudo code / specification for writing custom displays, like the one
                -- for "codeactions"
                -- specific_opts = {
                --   [kind] = {
                --     make_indexed = function(items) -> indexed_items, width,
                --     make_displayer = function(widths) -> displayer
                --     make_display = function(displayer) -> function(e)
                --     make_ordinal = function(e) -> string
                --   },
                --   -- for example to disable the custom builtin "codeactions" display
                --      do the following
                --   codeactions = false,
                -- }
            },
        },
    })

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

function M.sonictemplate()
    vim.keymap.set("n", "<Leader>s", "<Cmd>lua require('telescope').extensions.sonictemplate.templates{}<CR>")

    telescope.load_extension("sonictemplate")
end

return M
