local M = {}
local h = require('helper')

function M.config()
    require'clipboard-image'.setup {
        img_dir = function () return '.images' end,
        img_dir_txt = function () return '.images' end,
        img_name = function () return os.date('%Y-%m-%d-%H-%M-%S') end,
        prefix = function () return '![](' end,
        suffix = function () return ')' end
    }

    h.map("n", "<Leader><Leader>v", "<cmd>PasteImg<CR>")
    h.map("n", "<Leader><Leader>V", "<cmd>DeleteImg<CR>")
end

return M
