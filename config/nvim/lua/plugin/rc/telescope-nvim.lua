local M = {}

function M.config()
    vim.api.nvim_set_keymap("n", "<Leader>f", "<cmd>lua require('telescope.builtin').git_files{}<CR>",            { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>F", "<cmd>lua require('telescope.builtin').find_files{}<CR>",           { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>g", "<cmd>lua require('telescope.builtin').live_grep{}<CR>",            { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>o", "<cmd>lua require('telescope.builtin').oldfiles{}<CR>",             { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>b", "<cmd>lua require('telescope.builtin').buffers{}<CR>",              { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols{}<CR>", { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>[", "<cmd>lua require('telescope.builtin').lsp_references{}<CR>",       { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>t", "<cmd>lua require('telescope.builtin').treesitter{}<CR>",           { noremap = true, silent = true, })

    require('telescope').setup{
        defaults = {
            layout_strategy = "vertical",
        }
    }
end

return M
