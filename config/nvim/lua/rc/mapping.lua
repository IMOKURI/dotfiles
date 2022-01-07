-- -----------------------------------------------------------------------------
-- Leader {{{

vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- }}}

-- -----------------------------------------------------------------------------
-- File {{{

-- 変更があったときのみ、バッファを保存する
vim.keymap.set("n", "<Leader>w", "<Cmd>update<CR>")
-- すべてのバッファを保存する
vim.keymap.set("n", "<Leader><Leader>w", "<Cmd>wall<CR>")

-- ウィンドウを閉じる
vim.keymap.set("n", "qq", "<Cmd>close<CR>")
-- バッファを保存せず閉じる
vim.keymap.set("n", "QQ", "<Cmd>bdelete!<CR>")

-- Vim を終了する
vim.keymap.set("n", "<Leader>q", "<Cmd>qall<CR>")
-- 変更を保存せずに Vim を終了する
vim.keymap.set("n", "<Leader>Q", "<Cmd>qall!<CR>")

-- }}}

-- -----------------------------------------------------------------------------
-- Tab {{{

vim.keymap.set("n", "gt", "<Cmd>tabnew<CR>")

vim.keymap.set("n", "gn", "<Cmd>tabnext<CR>")
vim.keymap.set("n", "gp", "<Cmd>tabprevious<CR>")

-- }}}

-- -----------------------------------------------------------------------------
-- Terminal {{{

vim.keymap.set("n", "te", "<Cmd>terminal<CR>i")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- }}}

-- -----------------------------------------------------------------------------
-- Move {{{

vim.keymap.set({"n", "x"}, "j", "v:count ? 'j' : 'gj'", {expr = true})
vim.keymap.set({"n", "x"}, "k", "v:count ? 'k' : 'gk'", {expr = true})

vim.keymap.set({"n", "x"}, "H", "^")
-- Fold との複合マッピング
-- vim.keymap.set("n", "L", "$")
vim.keymap.set("x", "L", "$")

vim.keymap.set({"c", "i"}, "<C-a>", "<Home>")
vim.keymap.set({"c", "i"}, "<C-e>", "<End>")
vim.keymap.set({"c", "i"}, "<C-h>", "<Left>")
vim.keymap.set({"c", "i"}, "<C-l>", "<Right>")

vim.keymap.set("n", "gf", "gF")

-- }}}

-- -----------------------------------------------------------------------------
-- Buffer, Window {{{

vim.keymap.set("n", "<C-j>", "<Cmd>lua require('util').move_win('j')<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>lua require('util').move_win('k')<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>lua require('util').move_win('l')<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>lua require('util').move_win('h')<CR>")

vim.keymap.set("n", "<Leader><Tab>", "<C-^>")

-- }}}

-- -----------------------------------------------------------------------------
-- Fold {{{

vim.keymap.set("n", "l", "foldclosed('.') != -1 ? 'zo' : 'l'", {expr = true})
vim.keymap.set("n", "L", "foldclosed('.') != -1 ? 'zO' : '$'", {expr = true})

vim.keymap.set("n", "zl", "zR")
vim.keymap.set("n", "z,", "zMzv")

vim.keymap.set("n", ",", "<Cmd>lua require('util').close_fold()<CR>")

-- }}}

-- -----------------------------------------------------------------------------
-- Search, Replace {{{

vim.keymap.set("n", "<Leader><Esc>", ":nohlsearch<CR>")

-- }}}

-- -----------------------------------------------------------------------------
-- Indent {{{

vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")

-- }}}

-- -----------------------------------------------------------------------------
-- Yank, Paste {{{

-- 1文字削除を削除レジスタにいれる
vim.keymap.set("n", "x", '"_x')

-- }}}

-- vim:foldmethod=marker
