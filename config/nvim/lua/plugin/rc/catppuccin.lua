local M = {}
local catppuccin = require("catppuccin")
local colors = require("catppuccin.api.colors").get_colors()

function M.config()
    catppuccin.setup({})

    catppuccin.remap({
        HighlightedCursorLineNr = { fg = colors.red },
        HighlightedLineNr = { fg = colors.white },
        HighlightedLineNr1 = { fg = colors.maroon },
        HighlightedLineNr2 = { fg = colors.peach },
        HighlightedLineNr3 = { fg = colors.yellow },
        HighlightedLineNr4 = { fg = colors.green },
        HighlightedLineNr5 = { fg = colors.blue },
        DimLineNr = { fg = colors.black4 },

        ActiveWindow = { bg = colors.black2 },
        InactiveWindow = { bg = colors.black0 },

        WinBarContent = { fg = colors.black2, bg = colors.sky },
        WinBarSeparator = { fg = colors.sky },

        ColorColumn = { bg = colors.black1 }
    })

    vim.opt.winhighlight = "Normal:ActiveWindow,NormalNC:InactiveWindow,CursorLineNr:HighlightedCursorLineNr"

    vim.api.nvim_cmd({
        cmd = "colorscheme",
        args = { "catppuccin" },
    }, {})
end

return M
