local M = {}
local colors = require("nebulous.functions").get_colors("midnight")

function M.config()
    require("nebulous").setup({
        variant = "midnight",
        custom_colors = {
            CursorLineNr = { fg = colors.Red },
            HighlightedLineNr = { fg = colors.White },
            HighlightedLineNr1 = { fg = colors.Yellow },
            HighlightedLineNr2 = { fg = colors.Aqua },
            HighlightedLineNr3 = { fg = colors.Green },
            HighlightedLineNr4 = { fg = colors.Blue },
            HighlightedLineNr5 = { fg = colors.Magenta },
            DimLineNr = { fg = colors.DarkGrey },
            ActiveWindow = { bg = colors.Black },
            InactiveWindow = { bg = colors.background },
            WinBarContent = { fg = colors.Blue, bg = colors.background },
            WinBarSeparator = { fg = colors.Aqua, bg = colors.background },
        },
    })

    vim.opt.winhighlight = "Normal:ActiveWindow,NormalNC:InactiveWindow"
end

return M
