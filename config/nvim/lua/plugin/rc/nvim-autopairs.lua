local M = {}

function M.config()
    local npairs = require'nvim-autopairs'
    local Rule   = require'nvim-autopairs.rule'

    npairs.setup({
        ignored_next_char = "[%w%.]"
    })

    -- Jinja2
    npairs.add_rules({
        Rule("%", "%")
            :with_pair(function (opts)
                local pair = opts.line:sub(opts.col - 1, opts.col)
                return vim.tbl_contains({'{}'}, pair)
            end),
        Rule(" ", " ")
            :with_pair(function (opts)
                local pair = opts.line:sub(opts.col - 2, opts.col + 1)
                return vim.tbl_contains({'{%%}'}, pair)
            end),
    })
end

return M
