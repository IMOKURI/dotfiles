local M = {}

function M.config()
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>f",
        "<cmd>lua require('telescope.builtin').find_files{}<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>g",
        "<cmd>lua require('telescope.builtin').live_grep{}<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>o",
        "<cmd>lua require('telescope.builtin').oldfiles{}<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>b",
        "<cmd>lua require('telescope.builtin').buffers{}<CR>",
        {
            noremap = true,
            silent = true,
        }
    )
end

return M
