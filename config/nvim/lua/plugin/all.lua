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

    -- Jenkins
    {'martinda/Jenkinsfile-vim-syntax'},

    -- ansible
    {'pearofducks/ansible-vim'},
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

    -- Clever f
    {'rhysd/clever-f.vim'},

    -- Sandwich
    {'machakann/vim-sandwich'},

    -- Lexima
    {'cohama/lexima.vim', opt = true},

    -- Operator
    {
        'kana/vim-operator-replace',
        requires = {
            "kana/vim-operator-user",
        },
        config = "require'plugin.rc.operator'.config()",
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        event = {"BufNewFile *", "BufRead *"},
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

    -- Snippet
    {
        'hrsh7th/vim-vsnip',
        setup = "require'plugin.rc.vim-vsnip'.setup()",
        config = "require'plugin.rc.vim-vsnip'.config()",
    },
    {'hrsh7th/vim-vsnip-integ'},

    -- Auto completion
    {
        'nvim-lua/completion-nvim',
        requires = {
            "hrsh7th/vim-vsnip",
            "hrsh7th/vim-vsnip-integ",
        },
        setup = "require'plugin.rc.completion-nvim'.setup()",
        config = "require'plugin.rc.completion-nvim'.config()",
    },

    {
        'steelsojka/completion-buffers',
        after = {
            "completion-nvim",
        },
        config = "require'plugin.rc.completion-buffers'.config()",
    },

    {
        'nvim-treesitter/completion-treesitter',
        after = {
            "completion-nvim",
            "nvim-treesitter",
        },
    },

    -- LSP
    {'nvim-lua/lsp-status.nvim'},
    {
        'neovim/nvim-lspconfig',
        event = {"BufNewFile *", "BufRead *"},
        requires = {
            "nvim-lua/completion-nvim",
            "nvim-lua/lsp-status.nvim",
        },
        after = {
            "completion-nvim",
            "lsp-status.nvim",
        },
        setup = "require'plugin.rc.nvim-lspconfig'.setup()",
        config = "require'plugin.rc.nvim-lspconfig'.config()",
    },

    -- Status line
    {
        'tjdevries/express_line.nvim',
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = "require'plugin.rc.express_line-nvim'.config()",
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
