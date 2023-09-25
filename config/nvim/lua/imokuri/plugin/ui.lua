return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        build = function() require("catppuccin").compile() end,
        dependencies = {
            "IMOKURI/line-number-interval.nvim",
        },
        config = function()
            local catppuccin = require("catppuccin")

            vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

            catppuccin.setup({
                integrations = {
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
                custom_highlights = function(colors)
                    return {
                        CursorLineNr = { fg = colors.red },
                        HighlightedLineNr = { fg = colors.lavender },
                        HighlightedLineNr1 = { fg = colors.peach },
                        HighlightedLineNr2 = { fg = colors.yellow },
                        DimLineNr = { fg = colors.surface1 },
                        WinBar = { fg = colors.yellow },
                        WinBarNC = { fg = colors.subtext0 },
                    }
                end,
            })

            vim.api.nvim_cmd({
                cmd = "colorscheme",
                args = { "catppuccin" },
            }, {})

            vim.g.line_number_interval_enable_at_startup = 1
            vim.g["line_number_interval#use_custom"] = 1
            vim.g["line_number_interval#custom_interval"] = { 1, 2, 10, 20, 30, 40, 50, 60, 70, 80, 90 }

            vim.api.nvim_cmd({
                cmd = "LineNumberIntervalEnable",
            }, {})
        end,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { { "mode", fmt = string.upper } },
                    lualine_b = { "filetype" },
                    lualine_c = { { "diagnostics", sources = { "nvim_lsp" } } },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end,
    },

    -- UI
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        event = "VimEnter",
        config = function()
            require("noice").setup({
                presets = {
                    long_message_to_split = true,
                    inc_rename = true,
                    lsp_doc_border = true,
                },
                routes = {
                    {
                        view = "notify",
                        filter = { event = "msg_showmode" },
                    },
                },
            })
        end,
    },

    -- Indent Guide
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = function()
            require("indent_blankline").setup({
                char = "|",
                buftype_exclude = { "terminal" },
                show_first_indent_level = false,
            })
        end,
    },

    -- Smart color column
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufRead",
        config = function()
            require("smartcolumn").setup({
                colorcolumn = "120",
            })
        end,
    },

    -- Quick Highlight
    {
        "t9md/vim-quickhl",
        keys = {
            { "<Leader>m", "<Plug>(quickhl-manual-this)", mode = { "n", "x" } },
            { "<Leader>M", "<Plug>(quickhl-manual-reset)", mode = { "n", "x" } },
        },
    },
}
