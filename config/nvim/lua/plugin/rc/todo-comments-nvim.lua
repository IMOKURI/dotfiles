local M = {}

function M.config()
    -- https://github.com/folke/todo-comments.nvim/issues/97
    -- HACK: #104 Invalid in command-line window
    local hl = require("todo-comments.highlight")
    local highlight_win = hl.highlight_win
    hl.highlight_win = function(win, force)
        pcall(highlight_win, win, force)
    end

    require("todo-comments").setup({})

    vim.keymap.set("n", "<Leader>t", "<Cmd>TodoTelescope<CR>")
end

return M
