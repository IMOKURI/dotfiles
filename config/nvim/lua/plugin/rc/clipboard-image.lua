local M = {}

function M.config()
    require("clipboard-image").setup({
        img_dir = function()
            return ".images"
        end,
        img_dir_txt = function()
            return ".images"
        end,
        img_name = function()
            return os.date("%Y-%m-%d-%H-%M-%S")
        end,
        prefix = function()
            return "![]("
        end,
        suffix = function()
            return ")"
        end,
    })

    vim.keymap.set("n", "<Leader><Leader>v", "<Cmd>PasteImg<CR>")
    vim.keymap.set("n", "<Leader><Leader>V", "<Cmd>DeleteImg<CR>")
end

return M
