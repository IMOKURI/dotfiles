local g = vim.g

g.do_filetype_lua = 1
g.did_load_filetypes = 0

vim.filetype.add({
    extension = {
        ["jupyterlab-settings"] = "json",
    },
    filename = {
        ["install"] = "sh",
    },
    pattern = {
        [".*Dockerfile.*"] = "dockerfile",
        [".*git/config.*"] = "gitconfig",
    },
})
