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

function M.test()
    vim.api.nvim_cmd({
        cmd = "packadd",
        args = { "runes.nvim" },
    }, {})

    local runes = require("runes")

    runes.run_spec(runes.spec({
        description = "Enjoy playground.",

        spec_setup = function()
            return { one = 1 }
        end,

        runes.test({
            "Test case 01",
            test = function()
                assert.eq["One should be equals to one."](one, 1)
            end,
        }),
    }))
end

return M
