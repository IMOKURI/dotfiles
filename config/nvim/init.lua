vim.loader.enable()

vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

require("imokuri.rc.option")
require("imokuri.rc.mapping")
require("imokuri.rc.autocmd")

require("imokuri.lazy")
