local h = require('helper')

-- -----------------------------------------------------------------------------
-- Disable {{{

-- Exモード使わない
h.map("n", "Q", "<Nop>")

-- 削除してinsertモード使わない(vim-sandwichのため)
h.map("n", "s", "<Nop>")
h.map("x", "s", "<Nop>")

-- }}}

-- -----------------------------------------------------------------------------
-- Leader {{{

h.map("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- }}}

-- -----------------------------------------------------------------------------
-- File {{{

-- バッファを保存する
h.map("n", "<Leader>w", "<cmd>write<CR>")
-- すべてのバッファを保存する
h.map("n", "<Leader><Leader>w", "<cmd>wall<CR>")

-- ウィンドウを閉じる
h.map("n", "qq", "<cmd>close<CR>")
-- バッファを保存せず閉じる
h.map("n", "QQ", "<cmd>bdelete!<CR>")

-- Vim を終了する
h.map("n", "<Leader>q", "<cmd>qall<CR>")
-- 変更を保存せずに Vim を終了する
h.map("n", "<Leader>Q", "<cmd>qall!<CR>")

-- }}}

-- -----------------------------------------------------------------------------
-- Tab {{{

h.map("n", "gt", "<cmd>tabnew<CR>")

h.map("n", "gn", "<cmd>tabnext<CR>")
h.map("n", "gp", "<cmd>tabprevious<CR>")

-- }}}

-- -----------------------------------------------------------------------------
-- Terminal {{{

h.map("n", "te", "<cmd>terminal<CR>i")

h.map("t", "<ESC>", "<C-\\><C-n>")

-- }}}

-- -----------------------------------------------------------------------------
-- Move {{{

h.map("n", "j", "v:count ? 'j' : 'gj'", {expr = true})
h.map("x", "j", "v:count ? 'j' : 'gj'", {expr = true})
h.map("n", "k", "v:count ? 'k' : 'gk'", {expr = true})
h.map("x", "k", "v:count ? 'k' : 'gk'", {expr = true})

h.map("n", "H", "^")
h.map("x", "H", "^")
-- Fold との複合マッピング
-- h.map("n", "L", "$")
h.map("x", "L", "$")

h.map("c", "<C-a>", "<Home>")
h.map("c", "<C-e>", "<End>")
h.map("c", "<C-h>", "<Left>")
h.map("c", "<C-l>", "<Right>")

h.map("i", "<C-a>", "<Home>")
h.map("i", "<C-e>", "<End>")
h.map("i", "<C-h>", "<Left>")
h.map("i", "<C-l>", "<Right>")

-- }}}

-- -----------------------------------------------------------------------------
-- Buffer, Window {{{

h.map("n", "<C-j>", "<cmd>lua require('util').move_win('j')<CR>")
h.map("n", "<C-k>", "<cmd>lua require('util').move_win('k')<CR>")
h.map("n", "<C-l>", "<cmd>lua require('util').move_win('l')<CR>")
h.map("n", "<C-h>", "<cmd>lua require('util').move_win('h')<CR>")

h.map("n", "<Leader><Tab>", "<C-^>")

-- }}}

-- -----------------------------------------------------------------------------
-- Fold {{{

h.map("n", "l", "foldclosed('.') != -1 ? 'zo' : 'l'", {expr = true})
h.map("n", "L", "foldclosed('.') != -1 ? 'zO' : '$'", {expr = true})

h.map("n", "zl", "zR")
h.map("n", "z,", "zMzv")

h.map("n", ",", "<cmd>lua require('util').close_fold()<CR>")

-- }}}

-- -----------------------------------------------------------------------------
-- Search, Replace {{{

h.map("n", "<Leader><ESC>", "<cmd>nohlsearch<CR>")

h.map("n", "#", "*:%s/<C-r>///g<Left><Left>", {noremap = false})
h.map("x", "//", [[ y/\V<C-R>=escape(@",'/\')<CR><CR>") ]])
h.map("x", "#", "y:%s///g<Left><Left>")

-- }}}

-- -----------------------------------------------------------------------------
-- Indent {{{

h.map("n", "<", "<<")
h.map("n", ">", ">>")

-- }}}

-- -----------------------------------------------------------------------------
-- Yank, Paste {{{

-- 1文字削除を削除レジスタにいれる
h.map("n", "x", '"_x')

-- }}}

-- vim:foldmethod=marker
