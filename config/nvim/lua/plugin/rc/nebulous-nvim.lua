local M = {}
local colors = require("nebulous.functions").get_colors("midnight")

function M.config()
    require('nebulous').setup({
        variant = "midnight",
        custom_colors = {
            CursorLineNr = { fg = colors.Aqua },
            HighlightedLineNr = { fg = colors.White },
            DimLineNr = { fg = colors.DarkGrey },
        }
    })
end

return M

