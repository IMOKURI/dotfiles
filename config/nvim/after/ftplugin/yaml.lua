local h = require("helper")

vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2

h.map("n", "<Leader>gf", "<cmd>lua require('ftplugin.yaml').go_task_file()<CR>")
