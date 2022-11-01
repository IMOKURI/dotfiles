local M = {}

function M.config()
    local colors = require("catppuccin.palettes").get_palette()
    require("colorful-winsep").setup({
        highlight = {
            guifg = colors.overlay0,
        },
    })
end

return M
