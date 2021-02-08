local M = {}

function M.config()
    vim.api.nvim_set_keymap("n", "<Leader>f", "<cmd>lua require('telescope.builtin').git_files{}<CR>",                             { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>F", "<cmd>lua require('telescope').extensions.fzf_writer.files()<CR>",                   { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>g", "<cmd>lua require('telescope').extensions.fzf_writer.grep()<CR>",                    { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>o", "<cmd>lua require('telescope').extensions.frecency.frecency()<CR>",                  { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>p", "<cmd>lua require('telescope').extensions.project.project{ change_dir = true }<CR>", { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>b", "<cmd>lua require('telescope.builtin').buffers{}<CR>",                               { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols{}<CR>",                  { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>[", "<cmd>lua require('telescope.builtin').lsp_references{}<CR>",                        { noremap = true, silent = true, })
    vim.api.nvim_set_keymap("n", "<Leader>t", "<cmd>lua require('telescope.builtin').treesitter{}<CR>",                            { noremap = true, silent = true, })

    require('telescope').setup{
        defaults = {
            layout_strategy = "flex",
        }
    }
    require('telescope').load_extension('project')
    require('telescope').load_extension('frecency')
    require('telescope').load_extension('fzf_writer')
    require('telescope').load_extension('fzy_native')
end

return M
