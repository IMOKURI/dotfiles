local M = {}

function M.setup()
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>a",
        ":EasyAlign<CR>",
        {
            silent = true,
        }
    )
    vim.api.nvim_set_keymap(
        "x",
        "<Leader>a",
        ":EasyAlign<CR>",
        {
            silent = true,
        }
    )
end

return M
