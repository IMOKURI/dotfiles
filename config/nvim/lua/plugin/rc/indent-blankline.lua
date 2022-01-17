local M = {}

function M.config()
    require("indent_blankline").setup({
        char = "|",
        buftype_exclude = { "terminal" },
        show_first_indent_level = false,

        -- treesitter
        use_treesitter = true,
        show_current_context = true,
    })
end

return M
