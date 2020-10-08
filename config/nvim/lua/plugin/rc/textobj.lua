local M = {}

function M.current_line_a()
    vim.api.nvim_command("normal! 0")
    local head_pos = vim.fn.getpos(".")
    vim.api.nvim_command("normal! $")
    local tail_pos = vim.fn.getpos(".")
    return {'v', head_pos, tail_pos}
end

function M.setup()
end

function M.config()
    -- TODO: This code does not work...
    -- vim.fn['textobj#user#plugin']({
    --     "line",
    --     ["-"] = {
    --         ["select-a-function"] = "lua require('plugin.rc.textobj').current_line_a",
    --         ["select-a"] = 'al',
    --         ["select-i-function"] = 'CurrentLineI',
    --         ["select-i"] = 'il',
    --     }
    -- })
end

return M
