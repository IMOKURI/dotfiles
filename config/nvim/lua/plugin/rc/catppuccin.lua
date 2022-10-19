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
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = {},
                    hints = {},
                    warnings = {},
                    information = {},
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
            ts_rainbow = true,
        },
        custom_highlights = {
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
