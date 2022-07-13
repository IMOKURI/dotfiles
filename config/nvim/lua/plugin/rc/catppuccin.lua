local M = {}
local catppuccin = require("catppuccin")
local colors = require("catppuccin.core.palettes.init").get_palette()

function M.config()
    catppuccin.setup({
        custom_highlights = {
            HighlightedCursorLineNr = { fg = colors.red },
            HighlightedLineNr = { fg = colors.text },
            HighlightedLineNr1 = { fg = colors.maroon },
            HighlightedLineNr2 = { fg = colors.peach },
            HighlightedLineNr3 = { fg = colors.yellow },
            HighlightedLineNr4 = { fg = colors.green },
            HighlightedLineNr5 = { fg = colors.teal },
            DimLineNr = { fg = colors.surface1 },

            ActiveWindow = { bg = colors.base },
            InactiveWindow = { bg = colors.mantle },

            WinBarContent = { fg = colors.base, bg = colors.sapphire },
            WinBarSeparator = { fg = colors.sapphire },

            ColorColumn = { bg = colors.mantle },
        },
    })

    vim.opt.winhighlight = "Normal:ActiveWindow,NormalNC:InactiveWindow,CursorLineNr:HighlightedCursorLineNr"

    vim.api.nvim_cmd({
        cmd = "colorscheme",
        args = { "catppuccin" },
    }, {})
end

return M
