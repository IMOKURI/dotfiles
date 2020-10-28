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

    -- Filetype: python
    use {'microsoft/vscode-python', branch = 'main', ft = {'python'}}
    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}}
    use {
        'tjdevries/apyrori.nvim',
        ft = {'python'},
        requires = {
            "nvim-lua/plenary.nvim",
        },
       config = "require'plugin.rc.apyrori'.config()",
    }

    -- Filetype: csv
    use {'mechatroner/rainbow_csv', ft = {'csv'}}

    -- Filetype: markdown
    use {
        'dhruvasagar/vim-table-mode',
        ft = {'markdown'},
        setup = "require'plugin.rc.vim-table-mode'.setup()",
    }

    -- Filetype: terraform
    use {
        'hashivim/vim-terraform',
        ft = {'terraform'},
        setup = "require'plugin.rc.vim-terraform'.setup()",
    }

    -- Capture
    use {'tyru/capture.vim', cmd = {'Capture'}}

    -- Line number interval
    use {
        'IMOKURI/line-number-interval.nvim',
        setup = "require'plugin.rc.line-number-interval-nvim'.setup()",
    }

    -- Git sign
    use {
        'lewis6991/gitsigns.nvim',
        branch = 'main',
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = "require'plugin.rc.gitsigns'.config()",
    }

    -- Suda
    use {
        'lambdalisue/suda.vim',
        setup = "require'plugin.rc.suda-vim'.setup()",
    }

    -- Easy align
    use {
        'junegunn/vim-easy-align',
        cmd = {'EasyAlign'},
        setup = "require'plugin.rc.easy-align'.setup()",
    }

    -- Commentary
    use {
        'tpope/vim-commentary',
        cmd = {'Commentary'},
        setup = "require'plugin.rc.commentary'.setup()",
    }

    -- Line diff
    use {
        'AndrewRadev/linediff.vim',
        cmd = {'Linediff'},
        setup = "require'plugin.rc.linediff'.setup()",
    }

    -- Text object
    use {
        'kana/vim-textobj-indent',
        requires = {
            "kana/vim-textobj-user",
        },
       config = "require'plugin.rc.textobj'.config()",
    }

    -- Operator
    use {
        'kana/vim-operator-replace',
        requires = {
            "kana/vim-operator-user",
        },
        config = "require'plugin.rc.operator'.config()",
    }

    use {
        'romgrk/equal.operator',
        config = "require'plugin.rc.equal-operator'.config()",
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        event = {"BufNewFile *", "BufRead *"},
        config = "require'plugin.rc.nvim-treesitter'.config()",
    }

    use {
        'romgrk/nvim-treesitter-context',
        opt = true,
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
        after = {
            "nvim-treesitter",
        },
    }

    -- Snippet
    use {
        'hrsh7th/vim-vsnip',
        config = "require'plugin.rc.vim-vsnip'.config()",
    }

    -- Auto completion
    use {
        'nvim-lua/completion-nvim',
        requires = {
            "hrsh7th/vim-vsnip",
            "hrsh7th/vim-vsnip-integ",
        },
        setup = "require'plugin.rc.completion-nvim'.setup()",
        config = "require'plugin.rc.completion-nvim'.config()",
    }

    use {
        'steelsojka/completion-buffers',
        after = {
            "completion-nvim",
        },
        config = "require'plugin.rc.completion-buffers'.config()",
    }

    use {
        'nvim-treesitter/completion-treesitter',
        after = {
            "completion-nvim",
            "nvim-treesitter",
        },
    }

    -- LSP
    use {
        'nvim-lua/diagnostic-nvim',
        event = {"BufNewFile *", "BufRead *"},
        setup = "require'plugin.rc.diagnostic-nvim'.setup()",
        config = "require'plugin.rc.diagnostic-nvim'.config()",
    }
    use {
        'neovim/nvim-lspconfig',
        event = {"BufNewFile *", "BufRead *"},
        requires = {
            "nvim-lua/completion-nvim",
            "nvim-lua/diagnostic-nvim",
            "nvim-lua/lsp-status.nvim",
        },
        after = {
            "completion-nvim",
            "diagnostic-nvim",
            "lsp-status.nvim",
        },
        setup = "require'plugin.rc.nvim-lspconfig'.setup()",
        config = "require'plugin.rc.nvim-lspconfig'.config()",
    }

    -- Status line
    use {
        'tjdevries/express_line.nvim',
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = "require'plugin.rc.express_line-nvim'.config()",
    }

    -- Fuzzy finder
    use {
        'nvim-lua/telescope.nvim',
        requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = "require'plugin.rc.telescope-nvim'.config()",
    }
end)
