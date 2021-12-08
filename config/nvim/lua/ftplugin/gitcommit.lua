local M = {}

function M.select_type()
    local _, _, type = string.find(vim.api.nvim_get_current_line(), '# (%w+) ')

    vim.cmd('silent! normal! "_dip')
    vim.api.nvim_set_current_line(string.format("%s: ", type))
    vim.cmd('startinsert!')
end

return M
