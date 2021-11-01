local M = {}

-- https://oroques.dev/notes/neovim-init/
function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.system_name()
    local system_name
    if vim.fn.has("unix") == 1 then
        system_name = "Linux"
    elseif vim.fn.has('win32') == 1 then
        system_name = "Windows"
    else
        print("Unsupported system.")
    end
    return system_name
end

return M
