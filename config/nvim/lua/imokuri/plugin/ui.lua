return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        build = function() require("catppuccin").compile() end,
        dependencies = {
            "IMOKURI/line-number-interval.nvim",
            "nvim-lualine/lualine.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local catppuccin = require("catppuccin")

            vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

            catppuccin.setup({
                transparent_background = true,
                integrations = {
                    cmp = true,
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
                    telescope = { enabled = true },
                    treesitter = true,
                },
                custom_highlights = function(colors)
                    return {
                        CursorLineNr = { fg = colors.red },
                        Folded = { bg = colors.none },
                        HighlightedLineNr = { fg = colors.lavender },
                        HighlightedLineNr1 = { fg = colors.peach },
                        HighlightedLineNr2 = { fg = colors.yellow },
                        DimLineNr = { fg = colors.surface1 },
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

            vim.opt.fillchars = {
                stl = "─",
                stlnc = "─",
            }

            local C = require("catppuccin.palettes").get_palette(vim.g.catppuccin_flavour)
            local O = require("catppuccin").options
            local transparent_bg = O.transparent_background and "NONE" or C.base

            require("lualine").setup({
                options = {
                    theme = {
                        normal = {
                            a = { bg = transparent_bg, fg = C.blue, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.blue },
                        },
                        insert = {
                            a = { bg = transparent_bg, fg = C.green, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.green },
                        },
                        terminal = {
                            a = { bg = transparent_bg, fg = C.green, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.green },
                        },
                        command = {
                            a = { bg = transparent_bg, fg = C.peach, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.peach },
                        },
                        visual = {
                            a = { bg = transparent_bg, fg = C.mauve, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.mauve },
                        },
                        replace = {
                            a = { bg = transparent_bg, fg = C.red, gui = "bold" },
                            b = { bg = transparent_bg, fg = C.text },
                            c = { bg = transparent_bg, fg = C.red },
                        },
                        inactive = {
                            a = { bg = transparent_bg, fg = C.blue },
                            b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
                            c = { bg = transparent_bg, fg = C.overlay0 },
                        },
                    },
                    globalstatus = true,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { { "branch", icon = " " } },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = { { "diagnostics", sources = { "nvim_lsp" } } },
                    lualine_z = { "location" },
                },
                winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "%=", { "filetype", icon_only = true }, { "filename", path = 1 }, "%=" },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "%=", { "filetype", icon_only = true }, "filename", "%=" },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end,
    },

    {
        "rachartier/tiny-devicons-auto-colors.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = "VeryLazy",
        opts = {},
    },

    -- UI
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                presets = {
                    command_palette = true,
                    inc_rename = true,
                    long_message_to_split = true,
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

    -- Smart color column
    {
        "m4xshen/smartcolumn.nvim",
        event = "BufRead",
        opts = { colorcolumn = "120" },
    },

    -- Quick Highlight
    {
        "t9md/vim-quickhl",
        keys = {
            { "<Leader>m", "<Plug>(quickhl-manual-this)", mode = { "n", "x" }, desc = "Quick Highlight" },
            { "<Leader>M", "<Plug>(quickhl-manual-reset)", mode = { "n", "x" }, desc = "Reset Quick Highlight" },
        },
    },

    {
        "nacro90/numb.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
