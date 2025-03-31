local header = [[
( ･ ´｀(●) .oO( Neovim, Zzz... )
]]

return {
    -- A collection of small QoL plugins for Neovim.
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
            { "<Leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<Leader>D", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<Leader>E", function() Snacks.picker.icons() end, desc = "Emoji" },
            { "<Leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<Leader>d", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<Leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
            { "<Leader>f", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<Leader>g", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<Leader>h", function() Snacks.picker.notifications() end, desc = "Notification History" },
            { "<Leader>o", function() Snacks.picker.recent() end, desc = "Recent" },
            { "<Leader>/", function() Snacks.picker.search_history() end, desc = "Search History" },
        },
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
            notifier = { level = vim.log.levels.INFO },
            picker = {
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
