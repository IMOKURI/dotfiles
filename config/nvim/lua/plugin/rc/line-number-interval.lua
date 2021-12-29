local M = {}

function M.setup()
    vim.g.line_number_interval_enable_at_startup = 1
    vim.g['line_number_interval#use_custom'] = 1
    vim.g['line_number_interval#custom_interval'] = {1,2,3,4,5,10,20,30,40,50,60,70,80,90}
end

return M
