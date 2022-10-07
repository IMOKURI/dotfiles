local M = {}
local catppuccin = require("catppuccin")
local colors = require("catppuccin.palettes").get_palette()

function M.config()
    vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

    catppuccin.setup({
        integrations = {
            fidget = true,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,
            },
            ts_rainbow = true,
        },
        custom_highlights = {
            CursorLineNr = { fg = colors.red },
            HighlightedCursorLineNr = { fg = colors.red },
            HighlightedLineNr = { fg = colors.text },
            HighlightedLineNr1 = { fg = colors.maroon },
            HighlightedLineNr2 = { fg = colors.peach },
            HighlightedLineNr3 = { fg = colors.yellow },
            HighlightedLineNr4 = { fg = colors.green },
            HighlightedLineNr5 = { fg = colors.teal },
            DimLineNr = { fg = colors.surface2 },
            WinBar = { fg = colors.yellow },
            WinBarNC = { fg = colors.subtext0 },
        },
    })

    vim.api.nvim_cmd({
        cmd = "colorscheme",
        args = { "catppuccin" },
    }, {})
end

return M
