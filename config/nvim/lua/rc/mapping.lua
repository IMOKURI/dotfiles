local h = require('helper')

-- -----------------------------------------------------------------------------
-- Buffer, Window

-- ウィンドウを移動する
-- 端にいる場合は、画面を分割する
h.map("n", "<C-j>", "<cmd>lua require('util').move_win('j')<CR>")
h.map("n", "<C-k>", "<cmd>lua require('util').move_win('k')<CR>")
h.map("n", "<C-l>", "<cmd>lua require('util').move_win('l')<CR>")
h.map("n", "<C-h>", "<cmd>lua require('util').move_win('h')<CR>")

-- -----------------------------------------------------------------------------
-- Fold

-- 折りたたみを閉じる
h.map("n", ",", "<cmd>lua require('util').close_fold()<CR>")
