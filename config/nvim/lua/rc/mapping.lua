H = require('helper')

-- -----------------------------------------------------------------------------
-- Buffer, Window

-- ウィンドウを移動する
-- 端にいる場合は、画面を分割する
H.map("n", "<C-j>", "<cmd>lua require('util').move_win('j')<CR>")
H.map("n", "<C-k>", "<cmd>lua require('util').move_win('k')<CR>")
H.map("n", "<C-l>", "<cmd>lua require('util').move_win('l')<CR>")
H.map("n", "<C-h>", "<cmd>lua require('util').move_win('h')<CR>")
