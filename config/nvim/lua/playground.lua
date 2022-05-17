local M = {}

function M.echo(msg)
    vim.api.nvim_cmd({
        cmd = "!",
        args = { "echo", msg },
    }, {})
end

return M
