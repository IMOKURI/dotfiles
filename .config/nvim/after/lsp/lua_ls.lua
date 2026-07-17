return {
    settings = {
        -- https://github.com/LuaLS/lua-language-server/wiki/Settings
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                globals = vim.list_extend({
                    "Snacks",
                    "vim",
                }, {}),
            },
            completion = {
                callSnippet = "Replace",
            },
            hint = {
                enable = true,
            },
            format = {
                enable = false,
            },
        },
    },
}
