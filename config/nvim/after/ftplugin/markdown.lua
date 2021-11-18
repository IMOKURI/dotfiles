vim.wo.foldmethod = "marker"
vim.wo.foldmarker = "<details>,</details>"

vim.cmd[[command! DocToc !doctoc %:p]]
