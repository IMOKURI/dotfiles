local M = {}
local catppuccin = require("catppuccin")
local colors = require("catppuccin.palettes").get_palette()

function M.config()
    vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

    catppuccin.setup({
        compile = {
            enabled = true,
        },
        dim_inactive = {
            enabled = true,
        },
        custom_highlights = {
            ColorColumn = { bg = colors.mantle },
            CursorLineNr = { fg = colors.red },
            HighlightedCursorLineNr = { fg = colors.red },
            HighlightedLineNr = { fg = colors.text },
            HighlightedLineNr1 = { fg = colors.maroon },
            HighlightedLineNr2 = { fg = colors.peach },
            HighlightedLineNr3 = { fg = colors.yellow },
            HighlightedLineNr4 = { fg = colors.green },
            HighlightedLineNr5 = { fg = colors.teal },
            DimLineNr = { fg = colors.surface1 },
        },
    })

    vim.api.nvim_cmd({
        cmd = "colorscheme",
        args = { "catppuccin" },
    }, {})
end

return M
