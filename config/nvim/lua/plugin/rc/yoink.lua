local M = {}

function M.config()
    vim.g.yoinkIncludeDeleteOperations = 1
    vim.g.yoinkSavePersistently = 1

    vim.api.nvim_set_keymap("n", "p",     "<Plug>(YoinkPaste_p)",              { silent = true, })
    vim.api.nvim_set_keymap("n", "P",     "<Plug>(YoinkPaste_P)",              { silent = true, })
    vim.api.nvim_set_keymap("n", "<C-n>", "<Plug>(YoinkPostPasteSwapForward)", { silent = true, })
    vim.api.nvim_set_keymap("n", "<C-p>", "<Plug>(YoinkPostPasteSwapBack)",    { silent = true, })
end

return M
