local M = {}

function M.config()
    vim.api.nvim_set_keymap('n', '<Leader>h', '<cmd>lua require("hop").hint_words()<cr>', {})
    vim.api.nvim_set_keymap('n', '<Leader>/', '<cmd>lua require("hop").hint_patterns()<cr>', {})
end

return M
