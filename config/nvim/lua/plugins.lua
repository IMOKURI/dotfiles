-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local dir = string.format(
    '%s/site/pack/packer/opt/packer.nvim/',
    vim.fn.stdpath('data')
)

if vim.api.nvim_call_function('filereadable', {dir .. 'LICENSE'}) ~= 1 then
    local url = 'https://github.com/wbthomason/packer.nvim'
    vim.api.nvim_command(string.format('!git clone %q %q', url, dir))
end

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
-- vim._update_package_paths()

return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use {'microsoft/vscode-python', opt = true, ft = {'python'}}


end)
