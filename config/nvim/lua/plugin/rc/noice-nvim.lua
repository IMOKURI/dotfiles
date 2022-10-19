local M = {}

function M.config()
    require("noice").setup({
        routes = {
            {
                -- マクロ記録開始を表示する
                view = "notify",
                filter = { event = "msg_showmode" },
            },
            {
                -- ファイル保存のメッセージを非表示
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
            {
                -- 検索件数を非表示
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            },
        },
    })
end

return M
