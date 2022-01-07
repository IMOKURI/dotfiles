vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

vim.keymap.set("n", "<Leader>gf", "<Cmd>lua require('ftplugin.yaml').go_task_file()<CR>")
