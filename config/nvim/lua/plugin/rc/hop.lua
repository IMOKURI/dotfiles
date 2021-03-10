local M = {}

function M.config()
    vim.api.nvim_set_keymap('n', '<Leader>h', '<cmd>lua require("hop").hint_words()<cr>', {})
end

return M
