-- -----------------------------------------------------------------------------
-- Leader {{{

vim.keymap.set("n", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- }}}

-- -----------------------------------------------------------------------------
-- File {{{

vim.keymap.set("n", "<Leader>w", "<Cmd>update<CR>")
vim.keymap.set("n", "<Leader><Leader>w", "<Cmd>wall<CR>")

vim.keymap.set("n", "qq", "<Cmd>close<CR>")
vim.keymap.set("n", "QQ", "<Cmd>bdelete!<CR>")

vim.keymap.set("n", "<Leader>q", "<Cmd>qall<CR>")
vim.keymap.set("n", "<Leader>Q", "<Cmd>qall!<CR>")

-- }}}

-- -----------------------------------------------------------------------------
-- Terminal {{{

vim.keymap.set("n", "te", "<Cmd>terminal<CR>i")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- }}}

-- -----------------------------------------------------------------------------
-- Move {{{

vim.keymap.set({ "n", "x" }, "j", "v:count ? 'j' : 'gj'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count ? 'k' : 'gk'", { expr = true })

vim.keymap.set({ "n", "x" }, "H", "^")
-- Fold との複合マッピング
-- vim.keymap.set("n", "L", "$")
vim.keymap.set("x", "L", "$")

vim.keymap.set({ "c", "i" }, "<C-a>", "<Home>")
vim.keymap.set({ "c", "i" }, "<C-e>", "<End>")
vim.keymap.set({ "c", "i" }, "<C-h>", "<C-G>U<Left>")
vim.keymap.set({ "c", "i" }, "<C-l>", "<C-G>U<Right>")

vim.keymap.set("n", "gf", "gF")

-- }}}

-- -----------------------------------------------------------------------------
-- Buffer, Window {{{

vim.keymap.set("n", "<C-j>", "<Cmd>lua require('imokuri.util').move_win('j')<CR>")
vim.keymap.set("n", "<C-k>", "<Cmd>lua require('imokuri.util').move_win('k')<CR>")
vim.keymap.set("n", "<C-l>", "<Cmd>lua require('imokuri.util').move_win('l')<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>lua require('imokuri.util').move_win('h')<CR>")

vim.keymap.set("t", "<C-j>", "<Cmd>lua require('imokuri.util').move_win('j')<CR>")
vim.keymap.set("t", "<C-k>", "<Cmd>lua require('imokuri.util').move_win('k')<CR>")
vim.keymap.set("t", "<C-l>", "<Cmd>lua require('imokuri.util').move_win('l')<CR>")
vim.keymap.set("t", "<C-h>", "<Cmd>lua require('imokuri.util').move_win('h')<CR>")

vim.keymap.set("n", "<Leader><Tab>", "<C-^>")

-- }}}

-- -----------------------------------------------------------------------------
-- Fold {{{

vim.keymap.set("n", "l", "foldclosed('.') != -1 ? 'zo' : 'l'", { expr = true })
vim.keymap.set("n", "L", "foldclosed('.') != -1 ? 'zO' : '$'", { expr = true })

vim.keymap.set("n", "zl", "zR")
vim.keymap.set("n", "z,", "zMzv")

vim.keymap.set("n", ",", require("imokuri.util").close_fold)

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
-- Comment {{{

vim.keymap.set("n", "<Leader>c", "gcc")
vim.keymap.set("x", "<Leader>c", "gc")

-- }}}

-- -----------------------------------------------------------------------------
-- Yank, Paste {{{

-- 1文字削除を削除レジスタにいれる
vim.keymap.set("n", "x", '"_x')

-- }}}

-- vim:foldmethod=marker
