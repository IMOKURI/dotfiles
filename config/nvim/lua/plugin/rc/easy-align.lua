local M = {}

function M.setup()
    vim.keymap.set({"n", "x"}, "<Leader>a", ":EasyAlign<CR>", {remap = true})
end

return M
