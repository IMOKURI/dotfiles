local header = [[
( ･ ´｀(●) .oO( Neovim, Zzz... )
]]

return {
    -- A collection of small QoL plugins for Neovim.
    {
        "folke/snacks.nvim",
        dependencies = {
            "IMOKURI/snacks-picker-sonictemplate.nvim",
            "mattn/vim-sonictemplate",
            "nvim-lua/plenary.nvim",
        },
        priority = 1000,
        lazy = false,
        keys = {
            { "<Leader>/", function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<Leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<Leader>D", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<Leader>E", function() Snacks.picker.icons() end, desc = "Emoji" },
            { "<Leader>L", function() Snacks.lazygit.log() end, desc = "Lazygit Log" },
            { "<Leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<Leader>d", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<Leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
            { "<Leader>f", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<Leader>g", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<Leader>h", function() Snacks.picker.notifications() end, desc = "Notification History" },
            { "<Leader>l", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<Leader>o", function() Snacks.picker.recent() end, desc = "Recent" },
            { "<Leader>s", function() require("snacks_picker").sonictemplate() end, desc = "Sonictemplate" },
        },
        init = function()
            vim.g.sonictemplate_vim_template_dir = { string.format("%s/templates", vim.fn.stdpath("config")) }
        end,
        opts = {
            bigfile = {},
            dashboard = {
                preset = {
                    header = header,
                    keys = {
                        {
                            icon = " ",
                            key = "o",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')",
                        },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "U",
                            desc = "Update Plugins",
                            action = "<Cmd>Lazy sync<CR>",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                },
            },
            explorer = {},
            indent = {},
            lazygit = {},
            notifier = { level = vim.log.levels.INFO },
            picker = {
                layout = {
                    preset = function() return vim.o.columns >= 200 and "default" or "wide_vertical" end,
                },
                layouts = {
                    wide_vertical = {
                        layout = {
                            backdrop = false,
                            width = 0.8,
                            min_width = 80,
                            height = 0.8,
                            min_height = 30,
                            box = "vertical",
                            border = "rounded",
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", height = 0.7, border = "top" },
                        },
                    },
                },
                formatters = {
                    file = {
                        filename_first = true,
                    },
                },
                sources = {
                    explorer = {
                        auto_close = true,
                    },
                },
                win = {
                    input = {
                        keys = {
                            ["<C-n>"] = { "history_forward", mode = { "i", "n" } },
                            ["<C-p>"] = { "history_back", mode = { "i", "n" } },
                            ["<Esc>"] = { "close", mode = { "n", "i" } },
                            ["<Tab>"] = { "toggle_preview", mode = { "i", "n" } },
                        },
                    },
                },
            },
            quickfile = {},
        },
    },
}
