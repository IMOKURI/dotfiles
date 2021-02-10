local dir = string.format(
    '%s/site/pack/packer/opt/packer.nvim',
    vim.fn.stdpath('data')
)

if vim.fn.isdirectory(dir) == 0 then
    local url = 'https://github.com/wbthomason/packer.nvim'
    vim.api.nvim_command(string.format('!git clone %q %q', url, dir))
    vim.cmd [[packadd packer.nvim]]
end

function _G.run_packer(method)
    vim.cmd [[packadd packer.nvim]]
    require('plugin.load')[method]()
end

vim.cmd[[command! PackerInstall lua run_packer('install')]]
vim.cmd[[command! PackerUpdate  lua run_packer('update')]]
vim.cmd[[command! PackerSync    lua run_packer('sync')]]
vim.cmd[[command! PackerClean   lua run_packer('clean')]]
vim.cmd[[command! PackerCompile lua run_packer('compile')]]
