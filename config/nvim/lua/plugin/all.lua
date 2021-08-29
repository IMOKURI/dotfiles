return {
    -- Packer can manage itself as an optional plugin
    {'wbthomason/packer.nvim', opt = true},

    -- Color scheme
    {'IMOKURI/challenger-deep-theme-vim', opt = true},

    -- Filetype: python
    {'Vimjas/vim-python-pep8-indent', ft = {'python'}},

    -- Filetype: csv
    {'mechatroner/rainbow_csv', ft = {'csv'}},

    -- Filetype: markdown
    {
        'dhruvasagar/vim-table-mode',
        ft = {'markdown'},
        setup = "require'plugin.rc.vim-table-mode'.setup()",
    },

    -- Filetype: terraform
    {
        'hashivim/vim-terraform',
        ft = {'terraform'},
        setup = "require'plugin.rc.vim-terraform'.setup()",
    },

    -- Filetype: Jenkinsfile
    {'martinda/Jenkinsfile-vim-syntax', ft = {'Jenkinsfile'}},

    -- Filetype: ansible
    {
        'pearofducks/ansible-vim',
        ft = {'yaml', 'yaml.ansible', 'ansible_host', 'jinja2'},
    },
    {'thiagoalmeidasa/vim-ansible-vault', opt = true},

    -- Paste image
    -- Require xclip
    -- {
    --     'ekickx/clipboard-image.nvim',
    --     ft = {'markdown'},
    --     config = "require'plugin.rc.clipboard-image'.config()",
    -- },

    -- Capture
    {'tyru/capture.vim', cmd = {'Capture'}},

    -- Sonic template
    {
        'mattn/vim-sonictemplate',
        config = "require'plugin.rc.vim-sonictemplate'.config()",
    },

    -- Register
    {'tversteeg/registers.nvim'},

    -- Cursor word
    {'itchyny/vim-cursorword'},

    -- Quick highlight
    {'t9md/vim-quickhl', opt = true},

    -- Line number interval
    {
        'IMOKURI/line-number-interval.nvim',
        setup = "require'plugin.rc.line-number-interval-nvim'.setup()",
    },

    -- Git sign
    {
        'lewis6991/gitsigns.nvim',
        branch = 'main',
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = "require'plugin.rc.gitsigns'.config()",
    },

    -- Indent Guide
    {
        'lukas-reineke/indent-blankline.nvim',
        opt = true,
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
        after = {
            "nvim-treesitter",
        },
        config = "require'plugin.rc.indent-blankline'.config()",
    },


    -- Suda
    {
        'lambdalisue/suda.vim',
        setup = "require'plugin.rc.suda-vim'.setup()",
    },

    -- Easy align
    {
        'junegunn/vim-easy-align',
        cmd = {'EasyAlign'},
        setup = "require'plugin.rc.easy-align'.setup()",
    },

    -- Commentary
    {
        'tpope/vim-commentary',
        cmd = {'Commentary'},
        setup = "require'plugin.rc.commentary'.setup()",
    },

    -- Line diff
    {
        'AndrewRadev/linediff.vim',
        cmd = {'Linediff'},
        setup = "require'plugin.rc.linediff'.setup()",
    },

    -- Colorizer
    {
        'norcalli/nvim-colorizer.lua',
        cmd = {'ColorizerToggle'},
    },

    -- Terminal
    {
        'kassio/neoterm',
        cmd = {
            'Topen',
            'Ttoggle'
        },
        setup = "require'plugin.rc.neoterm'.setup()",
    },

    -- REPL
    {'IMOKURI/repl.vim'},

    -- Hop
    {
        'phaazon/hop.nvim',
        config = "require'plugin.rc.hop'.config()",
    },

    -- Sandwich
    {'machakann/vim-sandwich'},

    -- Operator
    {
        'kana/vim-operator-replace',
        requires = {
            "kana/vim-operator-user",
        },
        config = "require'plugin.rc.operator'.config()",
    },

    -- Text Objects
    {
        'kana/vim-textobj-line',
        requires = {
            "kana/vim-textobj-user",
        },
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        event = {"BufNewFile *", "BufRead *"},
        run = ":TSUpdate",
        config = "require'plugin.rc.nvim-treesitter'.config()",
    },

    {
        'nvim-treesitter/nvim-treesitter-refactor',
        opt = true,
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
        after = {
            "nvim-treesitter",
        },
    },

    {
        'p00f/nvim-ts-rainbow',
        opt = true,
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
        after = {
            "nvim-treesitter",
        },
    },

    {
        'romgrk/nvim-treesitter-context',
        opt = true,
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
        after = {
            "nvim-treesitter",
        },
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        opt = true,
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
        after = {
            "nvim-treesitter",
        },
    },

    -- {
    --     'code-biscuits/nvim-biscuits',
    --     opt = true,
    --     requires = {
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    --     after = {
    --         "nvim-treesitter",
    --     },
    --     config = "require'plugin.rc.nvim-biscuits'.config()",
    -- },

    -- Snippet
    {
        'hrsh7th/vim-vsnip',
        setup = "require'plugin.rc.vim-vsnip'.setup()",
        config = "require'plugin.rc.vim-vsnip'.config()",
    },

    -- Auto completion
    {
        'hrsh7th/nvim-cmp',
        requires = {
            "f3fora/cmp-spell",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "octaltree/cmp-look",
            "onsails/lspkind-nvim",
        },
        after = {
            "vim-vsnip",
        },
        config = "require'plugin.rc.nvim-cmp'.config()",
    },

    -- Auto Pairs
    {
        'windwp/nvim-autopairs',
        requires = {
            "hrsh7th/nvim-cmp",
        },
        after = {
            "nvim-cmp",
        },
        config = "require'plugin.rc.nvim-autopairs'.config()",
    },

    -- LSP
    {'nvim-lua/lsp-status.nvim'},
    {
        'neovim/nvim-lspconfig',
        event = {"BufNewFile *", "BufRead *"},
        requires = {
            "nvim-lua/lsp-status.nvim",
            "hrsh7th/nvim-cmp",
        },
        after = {
            "lsp-status.nvim",
            "nvim-cmp",
        },
        setup = "require'plugin.rc.nvim-lspconfig'.setup()",
        config = "require'plugin.rc.nvim-lspconfig'.config()",
    },

    -- Status line
    {
        'hoob3rt/lualine.nvim',
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = "require'plugin.rc.lualine'.config()",
    },

    -- Fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        requires = {
            "kyazdani42/nvim-web-devicons",
            "mattn/vim-sonictemplate",
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope-frecency.nvim",
            "nvim-telescope/telescope-fzf-writer.nvim",
            "nvim-telescope/telescope-fzy-native.nvim",
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-symbols.nvim",
            "tamago324/telescope-sonictemplate.nvim",
            "tami5/sql.nvim",
        },
        config = "require'plugin.rc.telescope-nvim'.config()",
    },
}
