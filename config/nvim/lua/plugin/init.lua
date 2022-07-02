local dir = string.format("%s/site/pack/packer/opt/packer.nvim", vim.fn.stdpath("data"))

if vim.fn.isdirectory(dir) == 0 then
    local url = "https://github.com/wbthomason/packer.nvim"
    vim.api.nvim_command(string.format("!git clone %q %q", url, dir))
    vim.api.nvim_cmd({
        cmd = "packadd",
        args = { "packer.nvim" },
    }, {})
end

function _G.run_packer(method)
    vim.api.nvim_cmd({
        cmd = "packadd",
        args = { "packer.nvim" },
    }, {})
    require("plugin.load")[method]()
end

vim.api.nvim_create_user_command("PackerInstall", "lua run_packer('install')", { bang = true })
vim.api.nvim_create_user_command("PackerUpdate", "lua run_packer('update')", { bang = true })
vim.api.nvim_create_user_command("PackerSync", "lua run_packer('sync')", { bang = true })
vim.api.nvim_create_user_command("PackerClean", "lua run_packer('clean')", { bang = true })
vim.api.nvim_create_user_command("PackerCompile", "lua run_packer('compile')", { bang = true })
