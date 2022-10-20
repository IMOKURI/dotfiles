local M = {}

function M.config()
    require("noice").setup({
        routes = {
            {
                -- 20行以上の出力は split 画面で表示する
                view = "split",
                filter = { event = "msg_show", min_height = 20 },
            },
            {
                -- マクロ記録開始を表示する
                view = "notify",
                filter = { event = "msg_showmode" },
            },
            {
                -- 検索件数を非表示にする
                filter = {
                    event = "msg_show",
                    kind = "search_count",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    any = {
                        { find = "fewer lines" }, -- 複数行削除
                        { find = "more lines" }, -- 複数行追加
                        { find = "written" }, -- ファイル保存
                        { find = "yanked" }, -- コピー
                    },
                },
                opts = { skip = true },
            },
        },
    })
end

return M
