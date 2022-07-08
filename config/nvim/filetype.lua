vim.filetype.add({
    extension = {
        ["jupyterlab-settings"] = "json",
    },
    filename = {
        ["install"] = "sh",
        ["swci-init"] = "sh",
    },
    pattern = {
        [".*Dockerfile.*"] = "dockerfile",
        [".*git/config.*"] = "gitconfig",
        [".*.make"] = "make",
    },
})
