local M = {}

function M.echo(msg)
    vim.api.nvim_cmd({
        cmd = "!",
        args = { "echo", msg },
    }, {})
end

function M.notify()
    vim.notify("This is an error message.", vim.log.levels.ERROR)
end

return M
