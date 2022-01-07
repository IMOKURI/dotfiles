vim.wo.foldmethod = "marker"
vim.wo.foldmarker = "<details>,</details>"

vim.api.nvim_add_user_command("DocToc", "!doctoc %:p", { bang = true })
