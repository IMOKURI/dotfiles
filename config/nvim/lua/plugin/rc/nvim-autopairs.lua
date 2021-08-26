local M = {}

function M.config()
    local npairs = require'nvim-autopairs'
    local Rule   = require'nvim-autopairs.rule'

    npairs.setup({})

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

    require("nvim-autopairs.completion.cmp").setup({
        map_cr = true, --  map <CR> on insert mode
        map_complete = true, -- it will auto insert `(` after select function or method item
    })
end

return M
