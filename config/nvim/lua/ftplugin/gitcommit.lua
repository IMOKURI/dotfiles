local M = {}

function M.select_type()
    local _, _, type = string.find(vim.api.nvim_get_current_line(), "# (%w+) ")

    vim.api.nvim_cmd({
        cmd = "normal",
        args = { '"_dip' },
        bang = true,
        mods = {
            emsg_silent = true,
        },
    }, {})
    vim.api.nvim_set_current_line(string.format("%s: ", type))
    vim.api.nvim_cmd({
        cmd = "startinsert",
        bang = true,
    }, {})
end

return M
